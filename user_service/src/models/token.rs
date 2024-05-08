use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
pub struct Token {
    pub id: String,
    pub exp: usize
}