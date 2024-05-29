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
use rocket::http::Header;
use rocket_cors::AllOrSome;
use rocket::fairing::{Fairing, Info, Kind};
use rocket::{Request, Response};

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
            "traefik.http.services.userservice.loadbalancer.server.port=8001",
            "traefik.http.routers.userservice.rule=PathPrefix(`/user/`)"
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

pub struct Cors;

#[rocket::async_trait]
impl Fairing for Cors {
    fn info(&self) -> Info {
        Info {
            name: "Cross-Origin-Resource-Sharing Fairing",
            kind: Kind::Response,
        }
    }

    async fn on_response<'r>(&self, _: &'r Request<'_>, response: &mut Response<'r>) {
        response.set_header(Header::new("Access-Control-Allow-Origin", "*"));
        response.set_header(Header::new("Access-Control-Allow-Methods", "GET, POST, PUT, PATCH, DELETE, OPTIONS"));
        response.set_header(Header::new("Access-Control-Allow-Headers", "*"));
        response.set_header(Header::new("Access-Control-Allow-Credentials", "true"));
    }
}

#[launch]
fn rocket() -> _ {
    //get address
    let address: String =  env::var("API_ADDRESS").unwrap();
    print!("{}", address);

    //set rocket configuration
    let config = rocket::Config {
        address: address.parse().unwrap(),
        port: 8001,
        ..Default::default()
    };

    //create rocket instance and mount routes
    let rocket_instance = rocket::custom(config)
        .mount("/", routes![user_routes::health])
        .mount("/user", routes![
            user_routes::health,
            user_routes::post_user,
            user_routes::get_user,
            user_routes::delete_user,
            user_routes::login,
            user_routes::follow_user,
            user_routes::get_pfp,
            user_routes::verify_user,
            user_routes::update_user,
            user_routes::update_pfp,
            user_routes::unfollow_user,
            user_routes::verify_jwt,
            user_routes::get_user_by_username,
            user_routes::search,
            user_routes::options_user_preflight,
            user_routes::get_user_by_id
        ])
        .attach(Cors);

    //check if service is in testing or needs to be registered
    if address != "127.0.0.1" {
        if let Err(err) = register_to_consul() {
            eprintln!("Failed to register with Consul: {}", err);
            std::process::exit(1); // Exit with error code 1 if registration fails
        }
    }

    //return rocket instance
    rocket_instance
}