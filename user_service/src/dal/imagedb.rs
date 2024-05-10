use std::io::Cursor;
use rocket::http::uri::Query;
use tokio_postgres::{NoTls, Client, Error};
use rocket::serde::json::{Json, Value};
use serde_json::json;
use std::env;
use rocket::fs::TempFile;
use std::fs::File;
use std::io::{self, Write, Seek, Read, BufReader, BufWriter};
use tempfile::NamedTempFile;

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

    pub async fn get_image(&self, id: &String) -> Result<NamedTempFile, Box<dyn std::error::Error>> {
        let query = self.client.prepare("SELECT image FROM images WHERE id = $1").await?;
        let row = match self.client.query_one(&query, &[id]).await {
            Ok(row) => row,
            Err(e) => return Err(Box::new(e)),
        };
        let image_data: Vec<u8> = row.get(0);

        let mut temp_file = NamedTempFile::new()?;
        temp_file.write_all(&image_data)?;
        temp_file.seek(std::io::SeekFrom::Start(0))?;
    
        Ok(temp_file)
    }
    
}