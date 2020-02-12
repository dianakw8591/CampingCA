require_relative '../config/environment'
require "tty-prompt"




def welcome
    puts "Welcome to the Campground Explorer!"
end



def main_menu
    prompt = TTY::Prompt.new
    choices = [
        {name: 'Explore recreation areas', value: 1},
        {name: 'Explore campgrounds', value: 2},
        {name: 'Check availability', value: 3},
        {name: 'View favorites', value: 4},
        {name: 'Update profile', value: 5},
        {name: 'Manage alerts', value: 6},
        {name: 'Exit explorer', value: 7}
    ]   
    prompt.select("What would you like do?", choices)
end
   
binding.pry


