use serde::{Serialize, Deserialize};
use crate::models::public_user::PublicUser;

#[derive(Clone, Serialize, Deserialize)]
pub struct SearchResult{
    pub users:  Vec<PublicUser>
}