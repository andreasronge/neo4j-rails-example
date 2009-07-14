# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_movies_session',
  :secret      => '53e2a9233a49d96f0bec935817d906e11d5c16ec5d20254f9677fbba874884cd198cac451f6430952594fc0593f16e5540407f3e14dc96b700d0ce844c8934d2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
