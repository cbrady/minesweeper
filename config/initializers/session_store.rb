# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mine_sweeper_session',
  :secret      => '11044a254702144937f11fb4af06524c59e740bd45c320f8c366b2818a30de19b95cffca992ccb92f9ea61e6ba75e803b70bb47635f57ad37dc002410e77b7d2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
