require_relative 'config/environment'
require 'sinatra/activerecord/rake'
require 'date'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

