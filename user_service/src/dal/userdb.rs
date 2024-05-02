use tokio_postgres::{NoTls, Client, Error};
use rocket::serde::json::{Json, Value};
use serde_json::json;
use crate::models::user::User;
use std::env;

pub struct UserDB {
    client: Client,
}

impl UserDB {
    pub async fn new() -> Result<Self, Error> {
        let url: String = env::var("URL").expect("URL not set");
        let (client, connection) = tokio_postgres::connect(&url, NoTls).await?;

        // Spawn a background task to handle the connection
        tokio::spawn(async move {
            if let Err(e) = connection.await {
                eprintln!("Connection error: {}", e);
            }
        });

        Ok(Self { client })
    }

    pub async fn create_user(&self, user: User) -> Result<(), Box<dyn std::error::Error>> {
        let query = self.client.prepare("INSERT INTO users (id, username, email, password, dob, pfp, bio, followers, following) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)").await?;
        self.client.execute(&query, &[&user.id, &user.username, &user.email, &user.password, &user.dob, &user.pfp.to_string(), &user.bio, &user.followers, &user.following,]).await?;

        Ok(())
    }

    pub async fn get_user(&self, id: String) -> Result<Value, Box<dyn std::error::Error>> {
        let query = self.client.prepare("SELECT * FROM users WHERE id = $1").await?;
        let row = self.client.query_one(&query, &[&id]).await?;
    
        let user = User {
            id: row.get("id"),
            username: row.get("username"),
            email: row.get("email"),
            password: row.get("password"),
            dob: row.get("dob"),
            pfp: row.get("pfp"),
            bio: row.get("bio"),
            followers: row.get("followers"),
            following: row.get("following"),
        };
    
        let json_value = serde_json::to_value(&user)?;

        Ok(json_value)
    }
    
}