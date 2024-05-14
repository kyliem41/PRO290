use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
#[derive(Debug)]
pub struct Login {
    pub username: String,
    pub password: String
}