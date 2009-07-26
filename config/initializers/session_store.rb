# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_handsofhope_inventory_session',
  :secret      => 'f13118b524ffc490716ee435fd987249dac7b767d26b7814b039c464610cd15a47cac0768ae473fe0e95c7f6d8e0beb071d28829dcf85ff51277a7f64e9f7c25'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
