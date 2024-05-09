use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]   
pub struct Update {
    pub column: String,
    pub new_data: String
}