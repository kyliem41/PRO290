use rocket::serde::json::{self, Json};
use rocket::http::Status;
use rocket::response::status;
use rocket::State;
use serde::Serialize;


#[derive(Serialize)]
struct SuccessResponse {
    status: String,
    id: Option<String>,
    cart: Option<String>,
}


#[derive(Serialize)]
struct ErrorResponse {
    status: String,
    message: String,
}

#[get("/health")]
pub async fn health() -> String { "OK".to_string()}