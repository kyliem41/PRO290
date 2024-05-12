use rocket::fs::TempFile;
use std::io::{self, Read, Write};
use std::fs::File;
use std::fs;
use std::path::Path;
use rocket::fs::NamedFile;
use std::path::PathBuf;
use rocket::http::ContentType;
use std::time::SystemTime;
use rocket::http::Status;

fn does_dir_exist() -> io::Result<()> {
    let images_dir = "./images";
    if !Path::new(&images_dir).exists() {
        fs::create_dir(&images_dir)?;
    }
    Ok(())
}

pub fn save_image(id: &String, pfp: TempFile<'_>) -> io::Result<()> {

    does_dir_exist()?;
    let tempfile_path: Option<&Path> = pfp.path();


    let mut infile: File = match pfp.path() {
        Some(path) => File::open(path)?,
        None => return Err(io::Error::new(io::ErrorKind::Other, "Could not get tempfile path")),
    };

    let mut data: Vec<u8> = Vec::new();
    infile.read_to_end(&mut data)?;

    let output_jpeg_path: String = format!("./images/{}.jpg", id);
    let mut outfile: File = File::create(output_jpeg_path)?;
    outfile.write_all(&data)?;

    Ok(())
}

pub async fn get_image(id: &str) -> Option<NamedFile> {
    let file_path = format!("./images/{}.jpg", id);

    if !Path::new(&file_path).exists() {
        return None;
    }

    match NamedFile::open(&file_path).await {
        Ok(named_file) => Some(named_file),
        Err(_) => None,
    }
}

pub fn update_image(id: String, pfp: TempFile<'_>) {
    
}