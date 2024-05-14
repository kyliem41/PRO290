use uuid::Uuid;
use crate::models::{login::Login, token::Token};
use jsonwebtoken::{encode, decode, Header, EncodingKey, DecodingKey, Algorithm, Validation};
use std::env;
use rand::Rng;
use argon2::{
    password_hash::{
        rand_core::OsRng,
        PasswordHash, PasswordHasher, PasswordVerifier, SaltString
    },
    Argon2
};

//generates a unique id
pub fn generate_uuid() -> Uuid {
    let uuid = Uuid::new_v4();
    uuid
}

//hashes a password with a random salt
pub fn hash_password(password: String) -> String {
    let salt = SaltString::generate(&mut OsRng);
    let argon2 = Argon2::default();
    let password_hash = argon2.hash_password(password.as_bytes(), &salt).unwrap().to_string();
    password_hash
}

//verifies if a plain text and hashed password match
pub fn verify_password(password: &String, hashed_password: &String) -> bool {
    let parsed_hash = PasswordHash::new(hashed_password).unwrap();
    Argon2::default().verify_password(password.as_bytes(), &parsed_hash).is_ok()
}

//creates a jwt using a user id and experiation time
pub fn create_jwt(id: String, expiration_time: i64) -> Result<String, jsonwebtoken::errors::Error> {
    let secret_key: String = env::var("SECRET_KEY").unwrap();
    let expiration = chrono::Utc::now()
        .checked_add_signed(chrono::Duration::seconds(expiration_time))
        .expect("valid timestamp")
        .timestamp();

    let token: Token = Token {
        id: id.clone(),
        exp: expiration as usize
    };

    let header = Header::new(Algorithm::HS256);
    let jwt = encode(&header, &token, &EncodingKey::from_secret(secret_key.as_ref()));

    match jwt {
        Ok(token) => {
            println!("JWT created successfully for user '{}'", id);
            Ok(token)
        },
        Err(err) => {
            println!("Error creating JWT for user '{}': {}", id, err);
            Err(err)
        }
    }
}

//verifies if a token is valid and contains a user id
pub fn verify_jwt(token: &String) -> Result<String, jsonwebtoken::errors::Error> {
    let secret_key: String = env::var("SECRET_KEY").unwrap();
    let validation = Validation::new(Algorithm::HS256);
    let token_data = decode::<Token>(token, &DecodingKey::from_secret(secret_key.as_ref()), &validation);

    match token_data {
        Ok(data) => {
            println!("JWT verification successful for user '{}'", data.claims.id);
            Ok(data.claims.id)
        },
        Err(err) => {
            println!("JWT verification failed: {}", err);
            Err(err)
        }
    }
}

//generated a random string of numbers 
//TODO give it a length why is this going to code.len() which is 0
pub fn generate_random_code() -> String {
    let mut code: String = "".to_string();

    for _ in 0..code.len() {
        let num: u8 = rand::thread_rng().gen_range(0..10);
        code.push_str(&num.to_string());
    }

    code
}