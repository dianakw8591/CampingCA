class User < ActiveRecord::Base
    has_many :alerts, dependent: :destroy
    has_many :campgrounds,  through: :alerts

    def self.prompt_for_user
        prompt = TTY::Prompt.new
        name = prompt.ask("Please enter your name to continue:")
        puts "\n\n"
        user = self.find_or_create_by(name: name)
        if user.email == nil
            puts "Welcome, #{name}!\n\n"
            email = prompt.ask("Please enter your email:")
            puts "\n\n"
            user.email = email
            user.save
        else
            puts "Welcome back, #{name}!"
            puts "\n\n"
        end
        user
    end

    def update_profile(menu)
        prompt = TTY::Prompt.new
        choices = [
            {name: 'Update name', value: 1},
            {name: 'Update email', value: 2},
            {name: 'Delete user', value: 3},
            {name: 'Main menu', value: 4}
        ]
        choice = prompt.select("What would you like to do?", choices)
        puts "\n\n"
        if choice == 1
            update_name
            update_profile(menu)
        elsif choice == 2
            update_email
            update_profile(menu)
        elsif choice == 3
            delete_user
        else
            menu.main_menu(self)
        end
    end


    def update_name
        prompt = TTY::Prompt.new
        name = prompt.ask("Please enter a new name:")
        self.name = name
        self.save
        puts "Name has been updated to #{self.name}"
        puts "\n\n"
        self
    end

    def update_email
        prompt = TTY::Prompt.new
        email = prompt.ask("Please enter a new email address:")
        self.email = email
        self.save
        puts "Email has been updated to #{self.email}"
        puts "\n\n"
        self
    end

    def delete_user
        prompt = TTY::Prompt.new
        delete = prompt.yes?("Are you sure you want to delete your account? 
            All alerts will be cancelled.")
        puts "\n\n"
        if delete
            self.destroy
            puts "Your account has been deleted."
            puts "Goodbye!\n\n"
        else
            update_profile
        end
    end

    def selectable_alerts
        self.alerts.map do |alert| 
            {name: "#{alert.campground.name} from #{alert.start_date} to #{alert.end_date}", value: alert}
        end
    end


end