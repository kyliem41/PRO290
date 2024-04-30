use serde::{Serialize, Deserialize};
use rocket::serde::json::serde_json;

#[derive(Clone, Serialize, Deserialize)]
pub struct User {
    pub id: String,
    pub username: String,
    pub email: String,
    pub password: String,
    pub dob: String, //maybe make this a date object but idk
    pub pfp: String, //place holder because i need to do some research to figure out how to do this
    pub followers: Vec<String>,
    pub following: Vec<String>
}

//finish
impl User {
    pub fn new() -> Self {
        Self{

        }
    }
}