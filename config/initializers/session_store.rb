# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rivendellcontrol_session',
  :secret      => 'b624848d08439559e280540b4a6b332a663cd30591825bc68dc9428baffabd2f891aa15552af310a9063c2d6df26f7011549761b9d6db9af37adcb0c27b197cf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
