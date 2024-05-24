use amiquip::Return;
use rocket::figment::util;
use uuid::Uuid;
use rocket::serde::json::{Json, Value};
use rocket::http::Status;
use rocket::response::status;
use rocket::form::Form;
use crate::models::user::User;
use crate::models::forms::{UserForm, ImageForm};
use crate::models::public_user::PublicUser;
use crate::models::login::Login;
use crate::models::update::Update;
use crate::models::producer;
use crate::utils::utils;
use crate::dal::userdb::UserDB;
use crate::dal::image;
use rocket::fs::NamedFile;
use serde_json::json;

const EXPERIATION_ONE_DAY: i64 = 86400;
const EXPERIATION_ONE_HOUR: i64 = 3600;

//TODO add default pfps and checking if a pfp is null

//post a user to the datbase takes in form data
#[post("/post", data = "<user_form>")]
pub async fn post_user(user_form: Form<UserForm>) -> status::Custom<String> {
    //init user properties
    let user_data: UserForm = user_form.into_inner();
    let user_id: String = utils::generate_uuid().to_string();
    let image_id: String = utils::generate_uuid().to_string();

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

    //attempt to save pfp
    // if let Err(err) = image::save_image(&image_id, user_data.pfp) {
    //     println!("{}", err);
    //     return status::Custom(Status::InternalServerError, "Error storing image to file".to_string())
    // }

    //hash password and create user object
    let hash: String = utils::hash_password(user_data.password);
    let user: User = User::new(user_id.clone(), user_data.username, user_data.email, hash, user_data.dob, image_id, "".to_string(), Vec::new(), Vec::new(), false);

    //save user in database
    match db.create_user(user.clone()).await {
        Ok(_) => {
            if let Ok(verification_token) = utils::create_jwt(user_id.clone(), EXPERIATION_ONE_HOUR) {
                let message = format!("Click this link to verifiy you account localhost:80/user/verify/{}", verification_token);
                producer::send_queue(message, user.email, "Yapper Verification".to_string(), "email_queue");
            }

            if let Ok(auth_token) = utils::create_jwt(user_id, EXPERIATION_ONE_DAY) {
                return status::Custom(Status::Created, auth_token)
            }

            return status::Custom(Status::Created, "".to_string())
        },
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error occured when creating user in database".to_string())
        }
    }
}

#[post("/login", data = "<login>")]
pub async fn login(login: Json<Login>) -> status::Custom<String> {
    println!("Received login request: {:?}", login);

    //create instance of database
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("Error creating connection to database: {}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    //check if username exists
    if db.does_field_exist("username", &login.username).await.unwrap() {
        println!("Username '{}' found in database", login.username);

        //get user id and password using usernmae
        match db.get_password_and_id(&login.username).await {
            Ok(user_data) => {
                println!("Retrieved user data: {:?}", user_data);

                //if password take from user = hashed password in database
                if utils::verify_password(&login.password, &user_data.0) {
                    println!("Password verification successful");

                    //create an auth token
                    if let Ok(jwt) = utils::create_jwt(user_data.1, EXPERIATION_ONE_DAY) {
                        println!("JWT created successfully: {}", jwt);
                        return status::Custom(Status::Ok, jwt)
                    } else {
                        println!("Error creating JWT");
                    }
                } else {
                    println!("Password verification failed");
                }
                return status::Custom(Status::InternalServerError, "Error validating user".to_string())
            }
            Err(err) => {
                println!("Error retrieving user data: {}", err);
                return status::Custom(Status::InternalServerError, "Error validating user".to_string())
            }
        }
    } else {
        println!("Username '{}' not found in database", login.username);
    }

    status::Custom(Status::NotFound, "Username was not found in database".to_string())
}


#[post("/follow/<token>/<followed_id>")]
pub async fn follow_user(token: String, followed_id: String ) -> status::Custom<String>{
    //check if given id is valid
    match Uuid::parse_str(&followed_id) {
        Ok(_) => {
            //verify auth token
            if let Ok(follower_id) = utils::verify_jwt(&token) {
                //create instance of database
                let db = match UserDB::new().await {
                    Ok(db) => db,
                    Err(err) => {
                        println!("UserDatabase: {}", err);
                        return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
                    }
                };

                //update data in database
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

#[post("/verify/<token>")]
pub async fn verify_user(token: String) -> status::Custom<String> {
    //validate auth token
    if let Ok(id) = utils::verify_jwt(&token) {
        //create instance of databse
        let db = match UserDB::new().await {
            Ok(db) => db,
            Err(err) => {
                println!("UserDatabase: {}", err);
                return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string());
            }
        };

        //update data in database
        if let Err(err) = db.verifiy_user(&id).await {
            println!("{}", err);
            return status::Custom(Status::InternalServerError, "Error updating user verification status".to_string());
        }

        return status::Custom(Status::Ok, "User verification successful".to_string());
    }

    status::Custom(Status::BadRequest, "Invalid token".to_string())
}

#[get("/health")]
pub fn health() -> String {
    "Ok".to_string()
}

//TODO this should be an auth token instead of sending a user id

#[get("/get/<token>")]
pub async fn get_user(token: String) -> status::Custom<Value>{
    if let Ok(id) = utils::verify_jwt(&token) {
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

        let response_json = json!({"message": "User not found"});
        return status::Custom(Status::NotFound, response_json)
    }

    let response_json = json!({"message": "invalid auth token"});
    return status::Custom(Status::BadRequest, response_json)
}

#[get("/search/<username>")]
pub async fn search(username: String) -> status::Custom<Value> {
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("{}", err);
            let response_json = json!({"message": "Error creating connection to database"});
            return status::Custom(Status::InternalServerError, response_json)
        }
    };

    match db.search_users(&username).await {
        Ok(users) => {
            if users.is_empty() {
                let response_json = json!({"message": "No users found"});
                return status::Custom(Status::NotFound, response_json)
            }

            let json = serde_json::to_value(users).unwrap();
            return status::Custom(Status::Ok, json)
        }
        Err(err) => {
            println!("{err}");
            let response_json = json!({"message": "Error finding users"});
            return status::Custom(Status::InternalServerError, response_json)
        }
    }
}

#[get("/check/email/<email>")]
pub async fn does_email_exist(email: String) -> Status {
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("{}", err);
            let response_json = json!({"message": "Error creating connection to database"});
            return Status::InternalServerError
        }
    };

    match db.does_field_exist("email", &email).await {
        Ok(exists) => {
            if exists {
                return Status::Ok
            }

            return Status::NotFound
        },
        Err(err) => {
            println!("{err}");
            return Status::InternalServerError
        }
    }
}

#[get("/get/username/<username>")]
pub async fn get_user_by_username(username: String) -> status::Custom<Value> {
    //create instance of database
    let db = match UserDB::new().await {
        Ok(db) => db,
        Err(err) => {
            println!("{}", err);
            let response_json = json!({"message": "Error creating connection to database"});
            return status::Custom(Status::InternalServerError, response_json)
        }
    }; 

    //get user json
    if let Ok (user_json) = db.get_user_with_username(username).await {
        return status::Custom(Status::Ok, user_json)
    }

    //nothing found
    let response_json = json!({"message": "User not found"});
    status::Custom(Status::NotFound, response_json)
}

#[get("/pfp/<token>")]
pub async fn get_pfp(token: String) -> Option<NamedFile> {
    //verify auth token
    if let Ok(id) = utils::verify_jwt(&token) {
        //create instance of db
        let user_db = match UserDB::new().await {
            Ok(db) => db,
            Err(err) => {
                println!("{}", err);
                return None;
            }
        };

        //get image_id from user and use that to return stored image
        if let Some(pfp_id) = user_db.get_column(&id, "pfp").await {
            return image::get_image(&pfp_id).await;
        }
    }

    None
}

#[get("/verify/token/<token>")]
pub fn verify_jwt(token: String) -> Status {
    if let Ok(id) = utils::verify_jwt(&token) {
        return Status::Ok
    }

    return Status::BadRequest
}

/*
TODO 
add the producer here to send an email with the code

 */
// #[post("/password/reset/<token>")]
// pub fn reset_password(token: String) -> status::Custom<String> {
    
// }

#[patch("/update/<token>", data = "<update>")]  
pub async fn update_user(token: String, update: Json<Update>) -> Status {
    //verify auth token
    if let Ok(id) = utils::verify_jwt(&token) {
        //create instance of database
        let db = match UserDB::new().await {
            Ok(db) => db,
            Err(err) => {
                println!("{}", err);
                return Status::InternalServerError 
            }
        };

        //update data in database
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

#[patch("/update/pfp/<token>", data = "<pfp>")]
pub async fn update_pfp(token: String, pfp: Form<ImageForm<'_>>) -> status::Custom<String> {
    //verify auth token
    if let Ok(id) = utils::verify_jwt(&token) {
        //create instance of user database
        let db = match UserDB::new().await {
            Ok(db) => db,
            Err(err) => {
                println!("{}", err);
                return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string());
            }
        };

        //get image id
        let image_id = match db.get_column(&id, "pfp").await {
            Some(pfp_id) => pfp_id,
            None => {
                return status::Custom(Status::NotFound, "No pfp found".to_string());
            }
        };

        //save new image
        if let Err(err) = image::save_image(&image_id, pfp.into_inner().image) {
            println!("{}", err);
            return status::Custom(Status::InternalServerError, "Error storing image to file".to_string());
        }

        return status::Custom(Status::Ok, "Updated pfp".to_string());
    }

    status::Custom(Status::BadRequest, "Invalid token".to_string())
}

#[delete("/delete/<id>")]
pub async fn delete_user(id: &str) -> status::Custom<String> {
    //check if valid id
    match Uuid::parse_str(id) {
        Ok(_) => {
            //create instance of database
            let db = match UserDB::new().await {
                Ok(db) => db,
                Err(err) => {
                    println!("{}", err);
                    return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
                }
            }; 

            //delete user from database
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
    //
    
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