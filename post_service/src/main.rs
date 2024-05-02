#[macro_use] // idk what macro use means
extern crate rocket;

mod routes;
mod models;
mod utils;
mod dal;


use rocket::launch;
use routes::post_service;
use utils::guid_generator;


#[get("/world")]
fn hello() -> &'static str {
    "Hello, world!"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![hello])
}


// #[tokio::main]
// async fn main() {
//     // all async code goes here
// }