use rocket::serde::json::{self, Json};
use rocket::http::Status;
use rocket::response::status;
use rocket::State;
use serde::Serialize;
use models::user::User;

#[post("/post", data = "<user>")]
pub fn post_user(user: Json<User>) {
    //
}