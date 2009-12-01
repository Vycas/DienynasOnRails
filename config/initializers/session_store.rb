# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_DienynasOnRails_session',
  :secret      => '2262e96acd2da7b1365fee36542928eaeb43dce11d2aca7675f9f16c63974efc90bc960966fc370e2ce5c9da6e97f06baf1c10dad7eb8f16cd8047b580d5978e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
