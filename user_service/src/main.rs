#[macro_use]
extern crate rocket;

mod utils;
mod models;

use std::env;

#[launch]
fn rocket() -> _ {
    let address =  env::var("API_ADDRESS").unwrap();

    let config = rocket::Config {
        address: address.parse().unwrap(),
        port: 8001,
        ..Default::default()
    };

    let rocket_instance = rocket::custom(config);

    rocket_instance
}