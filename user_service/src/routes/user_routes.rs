#![feature(proc_macro_hygiene, decl_macro)]
use uuid::Uuid;
use rocket::serde::json::{self, Json};
use rocket::{http::Status, request::FromParam};
use rocket::response::status;
use rocket::Data;
use rocket::State;
use serde::Serialize;
use serde_json::{json, Value};
use crate::models::user::User;
use crate::models::forms::UserForm;
use crate::utils::utils;
use crate::dal::userdb::UserDB;
use crate::dal::imagedb::ImageDB;
use rocket::http::ContentType;
use rocket::form::Form;

/*
TODO
add check for pfp being empty
add default pfp
hash password
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

    let user: User = User::new(user_data.username, user_data.email, user_data.password, user_data.dob, image_id, user_data.bio, user_data.followers, user_data.following);

    // Create an instance of UserDB
    let db = match UserDB::new().await {
        Ok(db) => db, // Wrap the UserDB instance in an Arc for thread safety
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    match db.create_user(user).await {
        Ok(_) => return status::Custom(Status::Created, "".to_string()),
        Err(err) => {
            println!("UserDatabase: {}", err);
            return status::Custom(Status::InternalServerError, "Error occured when creating user in database".to_string())
        }
    }
}

#[post("/login", data = "<login>")]
pub fn login(login: Json<Value>){

}

#[post("/password/reset", data = "<email>")]
pub fn reset_password(email: Json<Value>) {

}

#[post("/follow/<token>/<id>")]
pub fn follow_user(token: &str, id: &str ){

}

//TODO handle 404
#[get("/get/id/<id>")]
pub async fn get_user_by_id(id: &str) -> status::Custom<Value>{

    match Uuid::parse_str(id) {
        Ok(_) => {
            let db = match UserDB::new().await {
                Ok(db) => db,
                Err(err) => {
                    println!("{}", err);
                    let response_json = json!({"message": "Error creating connection to database"});
                    return status::Custom(Status::InternalServerError, response_json)
                }
            }; 

            if let Ok (user_json) = db.get_user(id.to_string()).await {
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

#[get("/health")]
pub fn health() -> String {
    "Ok".to_string()
}

#[get("/get/username/<username>")]
pub fn get_user_by_username(username: &str) {

}

#[patch("/update/<id>", data = "<update>")]
fn update_user(id: &str, update: Json<Value>){

}

#[patch("/update/pfp/<id>", data = "<pfp>")]
pub fn update_pfp(id: &str, pfp: Json<Value>) {

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

#[delete("/logout/<token>")]
pub fn logout(token: &str) {

}

#[delete("/unfollow/<token>/<id>")]
pub fn unfollow_user(token: &str, id: &str) {

}

// #[post("/test/file", data = "<user_form>")]
// pub fn test_getting_a_file(user_form: Form<UserForm>) -> String {
//     let test = &user_form.test;
//     println!("{}", test);

//     "Ok".to_string()
// }