class Menu
    def welcome
        puts "Welcome to the Campground Explorer!"
        puts "\n\n"
    end

    def main_menu(user)
        prompt = TTY::Prompt.new
        choices = [
            {name: 'Explore recreation areas', value: 1},
            {name: 'Explore campgrounds', value: 2},
            {name: 'Check availability', value: 3},
            {name: 'Manage alerts', value: 4},
            {name: 'Update profile', value: 5},
            {name: 'Exit explorer', value: 6}
        ]   
        choice = prompt.select("What would you like to do?", choices)
        puts "\n\n"
        if choice == 1
            RecArea.explore_rec_areas(self, user)
        elsif choice == 2
            puts "Campgrounds coming soon!"
        elsif choice == 3
            puts "Availability checking coming soon!"
        elsif choice == 4
            puts "alerts soon"
        elsif choice == 5
            user.update_profile(self)
        elsif choice == 6
            puts "Goodbye!\n\n"
        end
        
    end

    def run
        self.welcome
        user = User.prompt_for_user
        self.main_menu(user)
    end

end
