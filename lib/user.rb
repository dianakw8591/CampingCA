class User < ActiveRecord::Base
    has_many :favorites
    has_many :campgrounds,  through: :favorites

    def self.prompt_for_user
        prompt = TTY::Prompt.new
        name = prompt.ask("Please enter your name to continue:")
        user = self.find_or_create_by(name: name)
        if user.email == nil
            puts "Welcome, #{name}!"
            email = prompt.ask("Please enter your email:")
            user.email = email
            user.save
        else
            puts "Welcome back, #{name}!"
        end
        user
    end
    
end