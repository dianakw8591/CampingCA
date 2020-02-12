require_relative '../config/environment'
require "tty-prompt"




def welcome
    puts "Welcome to the Campground Explorer!"
end

def find_or_create_user
    prompt = TTY::Prompt.new
    name = prompt.ask("Please enter your name to continue:")
    user = User.find_or_create_by(name: name)
    if user.email = nil
        puts "Welcome, #{name}!"
        email = prompt.ask("Please enter your email:")
        user.email = email
    else
        puts "Welcome back, #{name}!"
    end
end

def main_menu
    prompt = TTY::Prompt.new
    choices = [
        {name: 'Explore recreation areas', value: 1},
        {name: 'Explore campgrounds', value: 2},
        {name: 'Check availability', value: 3}
        {name: 'View favorites', value: 4}
        {name: 'Update profile', value: 5}
        {name: 'Manage alerts', value: 6}
        {name: 'Exit explorer', value: 7}
    ]   
    selection = prompt.select("What would you like do?", choices)
end

binding.pry


