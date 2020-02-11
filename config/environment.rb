require 'bundler'
Bundler.require

Dotenv.load

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/rec_reservations.db')
require_all 'lib'

require 'net/http'
require 'open-uri'
require 'json'
