class Menu
    def welcome
        puts "Welcome to the Campground Explorer!"
        puts "\n\n"
    end

    def main_menu(user)
        prompt = TTY::Prompt.new
        choices = [
            {name: 'Explore recreation areas', value: 1},
            {name: 'Search for campgrounds', value: 2},
            {name: 'Check availability', value: 3},
            {name: 'Manage alerts', value: 4},
            {name: 'Update profile', value: 5},
            {name: 'Exit explorer', value: 6}
        ]   
        choice = prompt.select("What would you like to do?", choices)
        puts "\n\n"
        if choice == 1
            explore_rec_areas_menu(user)
        elsif choice == 2
            campground_find_by_name_menu(user)
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

    def explore_rec_areas_menu(user)
        prompt = TTY::Prompt.new
        choices = RecArea.all_rec_areas
        choices << {name: "Return to main menu", value: 1}
        choice = prompt.select("Choose an area!", choices)
        puts "\n\n"
        if choice == 1
            main_menu(user)
        else view_rec_area_menu(choice, user)
        end
    end

    def view_rec_area_menu(area, user)
        prompt = TTY::Prompt.new
        area.view_area
        choices = [
            {name: "View campgrounds", value: 1},
            {name: "Return to view areas", value: 2},
            {name: "Return to main menu", value: 3}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            view_campgrounds_menu(area, user)
        elsif choice == 2
            explore_rec_areas_menu(user)
        else
            main_menu(user)
        end
    end

    def view_campgrounds_menu(area, user)
        prompt = TTY::Prompt.new
        choices = area.view_campgrounds
        choices << {name: "Return to #{area.name}", value: 1}
        choices << {name: "Return to main menu", value: 2}
        choice = prompt.select("Select a campground to view details", choices)
        puts "\n\n"
        if choice == 1
            view_rec_area_menu(user)
        elsif choice == 2
            main_menu(user)
        else view_campground_details_menu(choice, user)
        end
    end

    def view_campground_details_menu(camp, user)
        prompt = TTY::Prompt.new
        puts "#{camp.name}\n\n"
        choices = [
            {name: "View description", value: 1}, #PARSE HTML
            {name: "View availability", value: 2},
            {name: "Return to campgrounds", value: 3},
            {name: "Return to main menu", value: 4}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            puts "#{camp.description}\n\n"
            view_campground_details_menu(camp, user)
        elsif choice == 2
            dates_for_availability_menu(camp, user)
        elsif choice == 3
            view_campgrounds_menu(camp.rec_area, user)
        else
            main_menu(user)
        end
    end

    def campground_find_by_name_menu(user)
        prompt = TTY::Prompt.new
        camp_name = prompt.ask("Enter a campground name to search:")
        puts "\n\n"
        camp = Campground.find_by_name(camp_name)
        if camp
            campground_search_menu(camp, user)
        else
            puts "Hmmm, I don't know that one. Please try again.\n\n"
        end
    end

    def campground_search_menu(camp, user)
        prompt = TTY::Prompt.new
        puts "#{camp.name}\n\n"
        choices = [
            {name: "View description", value: 1}, #PARSE HTML
            {name: "View availability", value: 2},
            {name: "Return to search", value: 3},
            {name: "Return to main menu", value: 4}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            puts "#{camp.description}\n\n"
            campground_search_menu(camp, user)
        elsif choice == 2
            dates_for_availability_menu(menu, user)
        elsif choice == 3
            campground_find_by_name_menu(user)
        else
            main_menu(user)
        end
    end

    def dates_for_availability_menu(choice, user)
    end
end
