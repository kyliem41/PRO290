use uuid::Uuid;
use rocket::serde::json::{self, Json};
use rocket::{http::Status, request::FromParam};
use rocket::response::status;
use rocket::State;
use serde::Serialize;
use serde_json::{json, Value};
use crate::models::user::User;
use crate::utils::utils;
use crate::dal::userdb::UserDB;

#[post("/post", data = "<user>")]
pub async fn post_user(user: Json<User>) -> status::Custom<String> {
    let mut user = user.into_inner();
    user.id = utils::generate_uuid().to_string();

    // Create an instance of UserDB
    let db = match UserDB::new().await {
        Ok(db) => db, // Wrap the UserDB instance in an Arc for thread safety
        Err(err) => {
            println!("{}", err);
            return status::Custom(Status::InternalServerError, "Error creating connection to database".to_string())
        }
    };

    match db.create_user(user).await {
        Ok(_) => return status::Custom(Status::Created, "".to_string()),
        Err(err) => {
            println!("{}", err);
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