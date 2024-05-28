use argon2::password_hash::PasswordHashString;
use tokio_postgres::{Client, Error, NoTls, Statement, types::ToSql}; // Added ToSql
use crate::models::update::{self, Update};
use rocket::{form, serde::json::{Json, Value}};
use serde_json::json;
use crate::models::user::{self, User};
use crate::models::public_user::PublicUser;
use std::env;
use std::str::FromStr; // Added FromStr

pub struct UserDB {
    client: Client,
}

impl UserDB {
    pub async fn new() -> Result<Self, Error> {
        let url: String = env::var("USER_URL").expect("URL not set");
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
        let query = self.client.prepare("INSERT INTO users (id, username, email, password, dob, pfp, bio, followers, following, verified) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)").await?;
        self.client.execute(&query, &[&user.id, &user.username, &user.email, &user.password, &user.dob, &user.pfp.to_string(), &user.bio, &user.followers, &user.following, &user.verified]).await?;

        Ok(())
    }

    pub async fn get_user_with_id(&self, id: String) -> Result<Value, Box<dyn std::error::Error>> {
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
            verified: row.get("verified")
        };
    
        let json_value = serde_json::to_value(&user)?;

        Ok(json_value)
    }

    pub async fn get_user_with_username(&self, username: String) -> Result<Value, Box<dyn std::error::Error>> {
        let query = self.client.prepare("SELECT * FROM users WHERE username = $1").await?;
        let row = self.client.query_one(&query, &[&username]).await?;
    
        let user = PublicUser {
            id: row.get("id"),
            username: row.get("username"),
            pfp: row.get("pfp"),
            bio: row.get("bio"),
            followers: row.get("followers"),
            following: row.get("following"),
        };
    
        let json_value = serde_json::to_value(&user)?;

        Ok(json_value)
    }

    pub async fn delete_user(&self, id: String) -> Result<(), Box<dyn std::error::Error>> {
        let query = self.client.prepare("DELETE FROM users WHERE id = $1").await?;
        self.client.execute(&query, &[&id]).await?;

        Ok(())
    }

    pub async fn does_field_exist(&self, field: &str ,username: &String) -> Result<bool, Box<dyn std::error::Error>> {
        let query = format!("SELECT COUNT(*) FROM users WHERE {} = $1", field);
        let statement = self.client.prepare(&query).await?;
        let row = self.client.query_one(&statement, &[username]).await?;
        let count: i64 = row.get(0);

        if count > 0 {
            return Ok(true)
        }
        
        Ok(false)
    }

    //this might not work for followers and following fields
    pub async fn get_column(&self, id: &String, column: &str) -> Option<String> {
        let query: String = format!("SELECT {} FROM users where id = $1", column);
        let statement = self.client.prepare(&query).await.ok()?;
        let row = self.client.query_one(&statement, &[id]).await.ok()?;
    
        Some(row.get(0))
    }

    pub async fn search_users(&self, username: &String) -> Result<Vec<PublicUser>, Box<dyn std::error::Error>> {
        let pattern = format!("%{}%", username);
        let statement = self.client.prepare("SELECT id, username, pfp, bio, followers, following FROM users WHERE username LIKE $1").await?;
        let rows = self.client.query(&statement, &[&pattern]).await?;

        let users: Vec<PublicUser> = rows.iter()
            .map(|row| {
                PublicUser {
                    id: row.get("id"),
                    username: row.get("username"),
                    pfp: row.get("pfp"),
                    bio: row.get("bio"),
                    followers: row.get("followers"),
                    following: row.get("following"),
                }
            })
            .collect();

        Ok(users)
    }


    pub async fn update_column(&self, id: &str, update: Update) -> Result<(), Box<dyn std::error::Error>> {
        let query: String = format!("UPDATE users SET {} = ${} WHERE id = ${}", update.column, 1, 2);
    
        let statement = self.client.prepare(&query).await?;
    
        let values: &[&(dyn ToSql + Sync)] = &[&update.new_data, &id];
        self.client.execute(&statement, values).await?;
    
        Ok(())
    }

    pub async fn verifiy_user(&self, id: &String) -> Result<(), Box<dyn std::error::Error>> {
        let statment = self.client.prepare("UPDATE users SET verified = True WHERE id = $1").await?;
        self.client.execute(&statment, &[id]).await?;

        Ok(())
    }

    pub async fn get_password_and_id(&self, username: &String) -> Result<(String, String), Box<dyn std::error::Error>> {
        let query = self.client.prepare("SELECT password, id FROM users WHERE username = $1").await?;
        let row = self.client.query_one(&query, &[username]).await?;
    
        let password: String = row.get("password");
        let id: String = row.get("id");
    
        Ok((password, id))
    }

    pub async fn follow_account(&self ,follower_id: String, followed_id: String) -> Result<(), Box<dyn std::error::Error>> {
        let query = self.client.prepare("UPDATE users SET following = array_append(following, $1) WHERE id = $2").await?;
        self.client.execute(&query, &[&followed_id, &follower_id]).await?;

        let query = self.client.prepare("Update users SET followers = array_append(followers, $1) WHERE id = $2").await?;
        self.client.execute(&query, &[&follower_id, &followed_id]).await?;

        Ok(())
    } 

    pub async fn unfollow_account(&self, follower_id: String, followed_id: String) -> Result<(), Box<dyn std::error::Error>> {
        let query = self.client.prepare("UPDATE users SET following = array_remove(following, $1) WHERE id = $2").await?;
        self.client.execute(&query, &[&followed_id, &follower_id]).await?;

        let query = self.client.prepare("UPDATE users SET followers = array_remove(followers, $1) WHERE id = $2").await?;
        self.client.execute(&query, &[&follower_id, &followed_id]).await?;
    
        Ok(())
    }
    
}