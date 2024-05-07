use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct Login {
    pub username: String,
    pub password: String
}