use serde::{Serialize, Deserialize};
use uuid::Uuid;

#[derive(Clone, Serialize, Deserialize)]
pub struct User {
    pub id: Uuid,
    pub username: String,
    pub email: String,
    pub password: String,
    pub dob: String, // maybe make this a date object but idk
    pub pfp: Uuid,
    pub bio: String,
    pub followers: Vec<String>,
    pub following: Vec<String>,
}

/*
TODO
make the pfp uuid default to a default pfp in the database
 */
impl User {
    pub fn new(username: String, email: String, password: String, dob: String, pfp: Uuid, bio: String, followers: Vec<String>, following: Vec<String>,) -> Self {
        Self {
            id: Uuid::new_v4(),
            username,
            email,
            password,
            dob,
            pfp,
            bio,
            followers,
            following,
        }
    }
}