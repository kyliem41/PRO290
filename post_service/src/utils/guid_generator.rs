use uuid::Uuid;

pub fn generate_guid() -> Uuid {
    // Generate a new random UUID (GUID)
    let uuid = Uuid::new_v4();

    //return
    uuid
}