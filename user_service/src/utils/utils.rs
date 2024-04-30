use uuid::Uuid;
use pwhash::bcrypt;
use pwhash::unix;

pub fn generate_uuid() -> Uuid {
    let uuid = Uuid::new_v4();
    uuid
}

pub fn hash_password(password: String) -> String {
    let hash = bcrypt::hash(password).unwrap();
    hash
}

pub fn verify_password(password: String, hash: String) -> bool {
    if unix::verify(password, &hash) {
        return true
    }

    false
}