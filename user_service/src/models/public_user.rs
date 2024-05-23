use serde::{Serialize, Deserialize};
use uuid::Uuid;

#[derive(Clone, Serialize, Deserialize)]
pub struct PublicUser {
    pub username: String,
    pub pfp: String,
    pub bio: String,
    pub followers: Vec<String>,
    pub following: Vec<String>,
}