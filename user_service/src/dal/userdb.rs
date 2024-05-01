use tokio_postgres::{NoTls, Connection, Error};
use std::env;

pub struct UserDB {
    connection: Connection
}

impl UserDB {
    async fn new() -> Result<Self, Error> {
        let url = env::var("URL").unwrap();
        
    }

    async fn create_user(user: User) {

    }
}