use amiquip::{Connection, Exchange, Publish};
use std::env;
use serde_json;
use serde::{Serialize, Deserialize};

#[derive(Serialize)]
struct MessageData {
    email: String,
    subject: String,
    message: String
}

pub fn send_queue(message: String, email: String, subject: String, queue: &str) {

    let address: String = env::var("RABBIT_URL").expect("RABBIT_URL environment variable not set");
    let mut connection = Connection::insecure_open(&address).expect("failed to connect to rabbit");
    let channel = connection.open_channel(None).expect("filed to open a channel");

    let message_data: MessageData = MessageData {
        email: email,
        subject: subject,
        message: message
    };
    let json_data = serde_json::to_string(&message_data).expect("failed to serialize JSON");

    let exchange = Exchange::direct(&channel);
    exchange
        .publish(Publish::new(json_data.as_bytes(), queue))
        .expect("failed to publish message");
}