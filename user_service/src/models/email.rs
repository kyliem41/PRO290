use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct Email {
    pub email: String
}