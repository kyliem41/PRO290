use std::fs::File;
use std::io::Write;
use rocket::fs::TempFile;
use tempfile::NamedTempFile;

#[derive(FromForm)]
pub struct UserForm<'r> {
    pub username: String,
    pub email: String,
    pub password: String,
    pub dob: String,
    pub pfp: TempFile<'r>,
    pub bio: String,
    pub followers: Vec<String>,
    pub following: Vec<String>,
}

#[derive(FromForm)]
pub struct ImageForm<'r> {
    pub id: String,
    pub image: TempFile<'r>
}