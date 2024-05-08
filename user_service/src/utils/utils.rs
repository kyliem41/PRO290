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

const EXPERIATION_ONE_DAY: i64 = 86400;

/*
TODO
add generation and verification using jwt for user auth
 */

pub fn generate_uuid() -> Uuid {
    let uuid = Uuid::new_v4();
    uuid
}

pub fn hash_password(password: String) -> String {
    let salt = SaltString::generate(&mut OsRng);
    let argon2 = Argon2::default();
    let password_hash = argon2.hash_password(password.as_bytes(), &salt).unwrap().to_string();
    password_hash
}

pub fn verify_password(password: &String, hashed_password: &String) -> bool {
    let parsed_hash = PasswordHash::new(hashed_password).unwrap();
    Argon2::default().verify_password(password.as_bytes(), &parsed_hash).is_ok()
}

//should make exp time a const
pub fn create_jwt(id: String) -> Result<String, jsonwebtoken::errors::Error> {
    let secret_key: String = env::var("SECRET_KEY").unwrap();
    let experiation = chrono::Utc::now()
        .checked_add_signed(chrono::Duration::seconds(EXPERIATION_ONE_DAY))
        .expect("valid timestap")
        .timestamp();

    let token: Token = Token {
        id: id,
        exp: experiation as usize
    };

    let header = Header::new(Algorithm::HS256);
    encode(&header, &token, &EncodingKey::from_secret(secret_key.as_ref()))
}

pub fn verify_jwt(token: &String) -> Result<String, jsonwebtoken::errors::Error> {
    let secret_key: String = env::var("SECRET_KEY").unwrap();
    let validation = Validation::new(Algorithm::HS256);
    let token_data = decode::<Token>(token, &DecodingKey::from_secret(secret_key.as_ref()), &validation)?;
    Ok(token_data.claims.id)
}

pub fn generate_random_code() -> String {
    let mut code: String = "".to_string();

    for _ in 0..code.len() {
        let num: u8 = rand::thread_rng().gen_range(0..10);
        code.push_str(&num.to_string());
    }

    code
}