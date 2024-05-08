extern crate image;
use image::{DynamicImage, ImageFormat};
use std::io::Cursor;
use rocket::http::uri::Query;
use tokio_postgres::{NoTls, Client, Error};
use rocket::serde::json::{Json, Value};
use serde_json::json;
use std::env;
use rocket::fs::TempFile;
use std::fs::File;
use std::io::Read;

pub struct ImageDB {
    client: Client,
}

impl ImageDB {
    pub async fn new() -> Result<Self, Error> {
        let url: String = env::var("IMAGE_URL").expect("URL not set");
        let (client, connection) = tokio_postgres::connect(&url, NoTls).await?;

        // Spawn a background task to handle the connection
        tokio::spawn(async move {
            if let Err(e) = connection.await {
                eprintln!("Connection error: {}", e);
            }
        });

        Ok(Self { client })
    }

    pub async fn post_image(&self, id: &String, image: TempFile<'_>) -> Result<(), Box<dyn std::error::Error>>{
        let mut pfp_data = Vec::new();
        let mut file = File::open(image.path().unwrap()).unwrap();
        file.read_to_end(&mut pfp_data).unwrap();

        let query = self.client.prepare("INSERT INTO images (id, image) VALUES($1, $2)").await?;
        self.client.execute(&query, &[id, &pfp_data]).await?;

        Ok(())
    }

    pub async fn get_image(&self, id: &String) -> Result<Vec<u8>, Box<dyn std::error::Error>> {
        let query = self.client.prepare("SELECT image FROM images WHERE id = $1").await?;
        let row = self.client.query_one(&query, &[id]).await?;
        let image_data: Vec<u8> = row.get(0);


        Ok(image_data)
    }
}