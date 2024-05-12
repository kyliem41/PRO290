use amiquip::{Connection, Exchange, Publish};
use std::env;

pub fn send_queue(message: String, queue: &str) {
    let address: String = env::var("RABBIT_URL").expect("RABBIT_URL environment variable not set");

    let mut connection = Connection::insecure_open(&address).expect("failed to connect to rabbit");

    let channel = connection.open_channel(None).expect("filed to open a channel");

    let exchange = Exchange::direct(&channel);

    exchange
        .publish(Publish::new(message.as_bytes(), queue))
        .expect("failed to publish message");
}