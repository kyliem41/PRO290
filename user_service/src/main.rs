#[macro_use]
extern crate rocket;
extern crate rocket_multipart_form_data;

mod utils;
mod models;
mod routes;
mod dal;

use std::env;
use rocket::figment::util;
use routes::user_routes;  

use reqwest;

fn register_to_consul() -> Result<(), Box<dyn std::error::Error>> {
    // Define unique service IDs
    let service_id = utils::utils::generate_uuid();
    let service_name = format!("userservice-{}", service_id);

    // Create request body
    let body = serde_json::json!({
        "ID": service_id,
        "Name": service_name,
        "Address": "userservice",
        "Port": 8001,
        "Check": {
            "HTTP": "http://userservice:8001/health",
            "Interval": "10s"
        },
        "Tags": [
            "traefik.enable=true",
            "traefik.http.services.cartservice.loadbalancer.server.port=8001",
            "traefik.http.routers.cartservice.rule=PathPrefix(`/user/`)"
        ]
    });

    // Make request to Consul for registration
    let client = reqwest::blocking::Client::new();
    client
        .put("http://consul:8500/v1/agent/service/register")
        .header(reqwest::header::CONTENT_TYPE, "application/json")
        .body(body.to_string())
        .send()?;

    // Return empty OK
    Ok(())
}

#[launch]
fn rocket() -> _ {
    let address: String =  env::var("API_ADDRESS").unwrap();
    print!("{}", address);

    let config = rocket::Config {
        address: address.parse().unwrap(),
        port: 8001,
        ..Default::default()
    };

    let rocket_instance = rocket::custom(config)
        .mount("/", routes![user_routes::health])
        .mount("/user", routes![user_routes::post_user, user_routes::get_user_by_id, user_routes::delete_user, user_routes::login, user_routes::follow_user, user_routes::unfollow_user, user_routes::update_user]);

    
    if address != "127.0.0.1" {
        if let Err(err) = register_to_consul() {
            eprintln!("Failed to register with Consul: {}", err);
            std::process::exit(1); // Exit with error code 1 if registration fails
        }
    }

    rocket_instance
}