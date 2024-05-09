use uuid::Uuid;
use rocket::serde::json::{self, Json};
use rocket::http::{Status, ContentType};
use rocket::response::status;
use rocket::response::Response;
use rocket::response::Responder;
use serde_json::{json, Value};
use crate::models::user::User;
use crate::models::forms::UserForm;
use crate::models::token::Token;
use crate::models::login::Login;
use crate::models::update::Update;
use crate::utils::utils;
use crate::dal::userdb::UserDB;
use crate::dal::imagedb::ImageDB;
use rocket::form::Form;
use std::io::Cursor;
use rocket::outcome::Outcome;
use std::path::PathBuf;
use rocket::response::status::Custom;

/*
TODO
add check for pfp being empty
add default pfp
*/
#[post("/post", data = "<user_form>")]
pub async fn post_user(user_form: Form<UserForm<'_>>) -> status::Custom<String> {
    let user_data: UserForm = user_form.into_inner();
    let image_id: String = utils::generate_uuid().to_string();

    // Create an instance of UserDB
    let db = match ImageDB::new().await {
        Ok(db) => db, // Wrap the UserDB instance in an Arc for thread safety
        Err(err) => {
            println!("ImageDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    if let Err(err) = db.post_image(&image_id, user_data.pfp).await {
        println!("ImageDatabase: {}", err);
        return status::Custom(Status::InternalServerError, format!("Error posting image to database"))
    }

    // Create an instance of UserDB
    let db = match UserDB::new().await {
        Ok(db) => db, // Wrap the UserDB instance in an Arc for thread safety
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    //check if username already exists
    if db.does_field_exist("username", &user_data.username).await.unwrap() {
        return status::Custom(Status::BadRequest, "Username needs to be unique".to_string())
    }

    //check if an account is linked to the email
    if db.does_field_exist("email", &user_data.email).await.unwrap() {
        return status::Custom(Status::BadRequest, "Email is already linked to an account".to_string())
    }

    let hash: String = utils::hash_password(user_data.password);
    let user: User = User::new(user_data.username, user_data.email, hash, user_data.dob, image_id, user_data.bio, user_data.followers, user_data.following, false);

    match db.create_user(user).await {
        Ok(_) => return status::Custom(Status::Created, "".to_string()),
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error occured when creating user in database".to_string())
        }
    }
}

#[post("/login", data = "<login>")]
pub async fn login(login: Json<Login>) -> status::Custom<String> {
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    if db.does_field_exist("username", &login.username).await.unwrap() {
        match db.get_password_and_id(&login.username).await {
            Ok(user_data) => {
                if utils::verify_password(&login.password, &user_data.0) {
                    if let Ok(jwt) = utils::create_jwt(user_data.1) {
                        return status::Custom(Status::Ok, jwt)
                    }
                }
                return status::Custom(Status::InternalServerError, "Error validating user".to_string())
            }
            Err(err) => {
                println!("{}", err);
                return status::Custom(Status::InternalServerError, "Error validating user".to_string())
            }
        }
    }

    status::Custom(Status::NotFound, "Username was not found in database".to_string())
}

#[post("/follow/<token>/<followed_id>")]
pub async fn follow_user(token: String, followed_id: String ) -> status::Custom<String>{
    match Uuid::parse_str(&followed_id) {
        Ok(_) => {
            if let Ok(follower_id) = utils::verify_jwt(&token) {
                let db = match UserDB::new().await {
                    Ok(db) => db,
                    Err(err) => {
                        println!("UserDatabase: {}", err);
                        return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
                    }
                };

                match db.follow_account(follower_id, followed_id).await {
                    Ok(_) => {
                        return status::Custom(Status::Ok, "".to_string())
                    },
                    Err(err) => {
                        println!("{}", err);
                        return status::Custom(Status::InternalServerError, "Error following account".to_string())
                    }
                }
            }

            return status::Custom(Status::InternalServerError, "Invalid Account Token".to_string())
        },
        Err(err) => {
            println!("{}", err);
            return status::Custom(Status::InternalServerError, "Id is not valid".to_string())
        }
    }
}

//should verify a jwt sent after creating an account exp should be 30 mins or less
//make change to user data
#[post("/verify/<token>")]
pub fn verify_user(token: String) {
    
}

#[get("/health")]
pub fn health() -> String {
    "Ok".to_string()
}

//TODO handle 404
#[get("/get/id/<id>")]
pub async fn get_user_by_id(id: String) -> status::Custom<Value>{

    match Uuid::parse_str(&id) {
        Ok(_) => {
            let db = match UserDB::new().await {
                Ok(db) => db,
                Err(err) => {
                    println!("{}", err);
                    let response_json = json!({"message": "Error creating connection to database"});
                    return status::Custom(Status::InternalServerError, response_json)
                }
            }; 

            if let Ok (user_json) = db.get_user_with_id(id).await {
                return status::Custom(Status::Ok, user_json)
            }

            //i think 404 should be here
            let response_json = json!({"message": "User not found"});
            status::Custom(Status::BadRequest, response_json)
        },
        Err(err) => {
            println!("{}", err);
            let response_json = json!({"message": "invalid id"});
            status::Custom(Status::BadRequest, response_json)
        }
    }
}

#[get("/get/username/<username>")]
pub async fn get_user_by_username(username: String) -> status::Custom<Value> {
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("{}", err);
            let response_json = json!({"message": "Error creating connection to database"});
            return status::Custom(Status::InternalServerError, response_json)
        }
    }; 

    if let Ok (user_json) = db.get_user_with_username(username).await {
        return status::Custom(Status::Ok, user_json)
    }

    //i think 404 should be here
    let response_json = json!({"message": "User not found"});
    status::Custom(Status::NotFound, response_json)
}

// #[get("/pfp/<token>")]
// pub async fn get_pfp(token: String) -> Result<Response<'static>, Custom<String>> {
//     if let Ok(id) = utils::verify_jwt(&token) {
//         let user_db = match UserDB::new().await {
//             Ok(db) => db,
//             Err(err) => {
//                 println!("{}", err);
//                 return Err(Custom(Status::InternalServerError, "Error creating connection to database".to_string()));
//             }
//         };

//         if let Ok(pfp_id) = user_db.get_column(&id, "pfp").await {
//             let image_db = match ImageDB::new().await {
//                 Ok(db) => db,
//                 Err(err) => {
//                     println!("ImageDatabase: {}", err);
//                     return Err(Custom(Status::InternalServerError, "Error creating connection to database".to_string()));
//                 }
//             };

//             if let Ok(image_data) = image_db.get_image_data(&pfp_id).await {
//                 // Create a response with the image bytes
//                 let response = Response::build()
//                     .header(ContentType::JPEG)
//                     .sized_body(image_data.len(), Cursor::new(image_data))
//                     .finalize();

//                 return Ok(response);
//             }
//         }
//     }

//     Err(Custom(Status::NotFound, "Image not found".to_string()))
// }

/*
TODO 
add the producer here to send an email with the code

 */
// #[post("/password/reset/<token>")]
// pub fn reset_password(token: String) -> status::Custom<String> {
    
// }

//make this an enum
#[patch("/update/<token>", data = "<update>")]  
pub async fn update_user(token: String, update: Json<Update>) -> Status {
    if let Ok(id) = utils::verify_jwt(&token) {

        let db = match UserDB::new().await {
            Ok(db) => db,
            Err(err) => {
                println!("{}", err);
                return Status::InternalServerError 
            }
        };

        let update: Update = update.into_inner();
        match db.update_column(&id, update).await {
            Ok(_) => {
                return Status::Ok
            }
            Err(err) => {
                println!("{}", err);
                return Status::InternalServerError
            }
        }
    }

    return Status::BadRequest
}


//should be a form
#[patch("/update/pfp/<token>", data = "<pfp>")]
pub fn update_pfp(token: String, pfp: Json<Value>) {

}

#[delete("/delete/<id>")]
pub async fn delete_user(id: &str) -> status::Custom<String> {
    match Uuid::parse_str(id) {
        Ok(_) => {
            let db = match UserDB::new().await {
                Ok(db) => db,
                Err(err) => {
                    println!("{}", err);
                    return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
                }
            }; 

            match db.delete_user(id.to_string()).await {
                Ok(_) => return status::Custom(Status::Ok, "".to_string()),
                Err(err) => {
                    println!("{}", err);
                    return status::Custom(Status::InternalServerError, "Error deleting user".to_string())
                }
            }
        },
        Err(err) => {
            println!("{}", err);
            status::Custom(Status::BadRequest, "invalid id".to_string())
        }
    }
}

#[delete("/unfollow/<token>/<followed_id>")]
pub async fn unfollow_user(token: String, followed_id: String) -> status::Custom<String> {
    match Uuid::parse_str(&followed_id) {
        Ok(_) => {
            if let Ok(follower_id) = utils::verify_jwt(&token) {
                let db = match UserDB::new().await {
                    Ok(db) => db,
                    Err(err) => {
                        println!("{}", err);
                        return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
                    }
                };

                match db.unfollow_account(follower_id, followed_id).await {
                    Ok(_) => {
                        return status::Custom(Status::Ok, "".to_string())
                    },
                    Err(err) => {
                        println!("{}", err);
                        return status::Custom(Status::InternalServerError, "Error unfollowing account".to_string())
                    }
                }
            }

            return status::Custom(Status::InternalServerError, "Invalid Account Token".to_string())
        },
        Err(err) => {
            println!("{}", err);
            status::Custom(Status::BadRequest, "invalid id".to_string())
        }
    }
}