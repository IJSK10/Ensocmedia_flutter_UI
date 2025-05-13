use bip39::{Language, Mnemonic};
use secp256k1::hashes::sha256;
use secp256k1::{rand, Message, Secp256k1, SecretKey};

#[flutter_rust_bridge::frb(sync)] 
pub struct UserKey {
    pub private_key: Vec<u8>,
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn just() -> String {
    "I am Athul".to_string()
}

#[flutter_rust_bridge::frb(sync)]
impl UserKey {
   pub fn new(seed: Vec<u8>) -> Self {
        let secp = Secp256k1::new();
        let secret_key = SecretKey::from_hashed_data::<sha256::Hash>("Hello world!".as_bytes());
        let public_key = secret_key.public_key(&secp).to_string();

        let private_key = secret_key.secret_bytes().to_vec();
        Self { private_key }
    }

    pub fn generate_signature(&self, message: String) -> String {
        let mut rng = rand::thread_rng();
        let random_data = [1, 2, 3];
        let mnemonic_from_entropy = Mnemonic::from_entropy(&random_data).unwrap();

        let secp = Secp256k1::new();
        let secret_key = SecretKey::from_slice(&hex::decode(&self.private_key).unwrap()).unwrap();
        let message = Message::from_hashed_data::<sha256::Hash>(message.as_bytes());

        let sig = secp.sign_ecdsa(&message, &secret_key).to_string();

        return sig;
    }
}
