#[macro_use]
extern crate rocket;

mod utils;
mod models;
mod routes;
mod dal;

use std::env;
use routes::user_routes;   

#[launch]
fn rocket() -> _ {
    let address =  env::var("API_ADDRESS").unwrap();

    let config = rocket::Config {
        address: address.parse().unwrap(),
        port: 8001,
        ..Default::default()
    };

    let rocket_instance = rocket::custom(config)
        .mount("/", routes![user_routes::health])
        .mount("/user", routes![user_routes::post_user]);

    rocket_instance
}