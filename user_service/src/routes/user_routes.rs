use uuid::Uuid;
use rocket::serde::json::{self, Json};
use rocket::{http::Status, request::FromParam};
use rocket::response::status;
use rocket::State;
use serde::Serialize;
use serde_json::Value;
use crate::models::user::User;
use crate::utils::utils;

#[post("/post", data = "<user>")]
pub fn post_user(user: Json<User>) {
    
    let mut user: User = user.into_inner();
    user.id = utils::generate_uuid();

    
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

#[get("/get/id/<id>")]
pub fn get_user_by_id(id: &str) {

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
pub fn delete_user(id: &str) {

}

#[delete("/logout/<token>")]
pub fn logout(token: &str) {

}

#[delete("/unfollow/<token>/<id>")]
pub fn unfollow_user(token: &str, id: &str) {

}