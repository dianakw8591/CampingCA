class Menu
    attr_accessor :user

    def run
        self.welcome
        user = User.prompt_for_user
        self.user = user
        main_menu
    end
    
    def welcome
        puts "Welcome to the Campground Explorer!"
        puts "\n\n"
    end

    def main_menu
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
            explore_rec_areas_menu
        elsif choice == 2
            camp = campground_search_by_name_menu
            view_campground_details_menu(camp)
        elsif choice == 3
            availability_menu
        elsif choice == 4
            view_alerts_menu
        elsif choice == 5
            user.update_profile(self)
        elsif choice == 6
            puts "Goodbye!\n\n"
        end  
    end

    def explore_rec_areas_menu
        prompt = TTY::Prompt.new
        choices = RecArea.all_rec_areas
        choices << {name: "Return to main menu", value: 1}
        choice = prompt.select("Choose an area!", choices)
        puts "\n\n"
        if choice == 1
            main_menu
        else view_rec_area_menu(choice)
        end
    end

    def view_rec_area_menu(area)
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
            view_campgrounds_menu(area)
        elsif choice == 2
            explore_rec_areas_menu
        else
            main_menu
        end
    end

    def view_campgrounds_menu(area)
        prompt = TTY::Prompt.new
        choices = area.view_campgrounds
        choices << {name: "Return to #{area.name}", value: 1}
        choices << {name: "Return to main menu", value: 2}
        choice = prompt.select("Select a campground to view details", choices)
        puts "\n\n"
        if choice == 1
            view_rec_area_menu(area)
        elsif choice == 2
            main_menu
        else view_campground_details_menu(choice)
        end
    end

    def view_campground_details_menu(camp)
        prompt = TTY::Prompt.new
        puts "#{camp.name}\n\n"
        choices = [
            {name: "View description", value: 1}, #PARSE HTML
            {name: "View availability", value: 2},
            {name: "View more campgrounds of #{camp.rec_area.name}", value: 3},
            {name: "Search for campgrounds by name", value: 4},
            {name: "Return to main menu", value: 5}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            puts "#{camp.description}\n\n"
            view_campground_details_menu(camp)
        elsif choice == 2
            availability_menu(camp)
        elsif choice == 3
            view_campgrounds_menu(camp.rec_area)
        elsif choice == 4
            camp = campground_search_by_name_menu
            view_campground_details_menu(camp)
        else
            main_menu
        end
    end

    # def campground_search_menu(camp)
    #     prompt = TTY::Prompt.new
    #     puts "#{camp.name}\n\n"
    #     choices = [
    #         {name: "View description", value: 1}, #PARSE HTML
    #         {name: "View availability", value: 2},
    #         {name: "Return to search", value: 3},
    #         {name: "View all of #{camp.rec_area.name}'s campgrounds", value: 4},
    #         {name: "Return to main menu", value: 5}
    #     ]
    #     choice = prompt.select("Select an option:", choices)
    #     puts "\n\n"
    #     if choice == 1
    #         puts "#{camp.description}\n\n"
    #         campground_search_menu(camp)
    #     elsif choice == 2
    #         availability_menu(camp)
    #     elsif choice == 3
    #         campground_find_by_name_menu
    #     elsif choice == 4
    #         view_campgrounds_menu(camp.rec_area)
    #     else
    #         main_menu
    #     end
    # end

    def availability_menu(camp = nil, date_array = [])
        if camp.nil?
            camp = campground_search_by_name_menu
        end
        if date_array.empty?
            date_array = get_dates
        end
        print_availability(camp, date_array[0], date_array[1])
        prompt = TTY::Prompt.new
        choices = [
            {name: "Change search dates", value: 1},
            {name: "Change campground", value: 2},
            {name: "Set an alert for this search", value: 3},
            {name: "View all of #{camp.rec_area.name}'s campgrounds", value: 4},
            {name: "Return to main menu", value: 5}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            availability_menu(camp, [])
        elsif choice == 2
            availability_menu(nil, date_array)
        elsif choice == 3
            alert_menu(camp, date_array)
        elsif choice == 4
            view_campgrounds_menu(camp.rec_area)
        else
            main_menu
        end
    end

    # def select_campground
    #     prompt = TTY::Prompt.new
    #     camp_name = prompt.ask("Enter a campground name to find availability:")
    #     puts "\n\n"
    #     camp = Campground.find_by_name(camp_name)
    #     if camp.nil?
    #         puts "Hmmm, I don't know that one. Please try again.\n\n"
    #         self.select_campground
    #     else
    #         camp
    #     end
    # end

    def campground_search_by_name_menu
        prompt = TTY::Prompt.new
        camp_name = prompt.ask("Enter a campground name to search, 'menu' to return to the main menu:")
        puts "\n\n"
        if camp_name == "menu"
            main_menu
        else
            camp = Campground.find_by_name(camp_name)
            if camp.nil?
                puts "Hmmm, I don't know that one. Please try again.\n\n"
                campground_search_by_name_menu
            else
                camp
            end
        end
    end


    def get_dates
        start_prompt = TTY::Prompt.new
        start_date = start_prompt.ask("What day are you arriving?:", convert: :date)
        end_prompt = TTY::Prompt.new
        end_date = end_prompt.ask("What date are you leaving?", convert: :date)
        puts "\n\n"
        [start_date, end_date]
    end

    def print_availability(camp, start_date, end_date)
        avail_array = camp.check_availability(start_date, end_date)
        puts "Sites available for #{camp.name}:"
        p avail_array
        # make this pretty - https://github.com/piotrmurach/tty-table
        puts "\n\n"
    end



    def alert_menu(camp = nil, date_array = [])
        camp.set_alert(date_array, user)
        puts "An alert has been set. You will be emailed when sites become available.\n\n"
        prompt = TTY::Prompt.new
        choices = [
            {name: "Set another alert", value: 1},
            {name: "Manage alerts", value: 2},
            {name: "Return to main menu", value: 3}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            availability_menu
        elsif choice == 2
            view_alerts_menu
        else
            main_menu
        end
    end

    def view_alerts_menu
        if user.alerts.empty?
            no_active_alerts
        else
            display_alerts
            prompt = TTY::Prompt.new
            choices = [
                {name: "Update an alert", value: 1},
                {name: "Delete an alert", value: 2},
                {name: "Return to main menu", value: 3}
            ]
            choice = prompt.select("Select an option:", choices)
            puts "\n\n"
            if choice == 1
                update_alert
            elsif choice == 2
                delete_alert
            else
                main_menu
            end
        end
    end

    def no_active_alerts
        puts "You have no active alerts.\n\n"
        prompt = TTY::Prompt.new
        new_alert = prompt.yes?("Would you like to set an alert?")
        puts "\n\n"
        if new_alert
            availability_menu
        else
            main_menu
        end
    end

    def display_alerts
        num = user.alerts.count
        puts "You currently have #{num} alert(s) set:\n\n"
        user.alerts.each do |alert|
            alert.display_alert
        end
        puts "\n\n"
    end

    def choose_alert
        prompt = TTY::Prompt.new
        choices = user.selectable_alerts
        alert = prompt.select("Select an option:", choices)
        puts "\n\n"
        alert
    end

    def update_alert
        alert = choose_alert
        prompt = TTY::Prompt.new
        choices = [
            {name: "Update dates", value: 1},
            {name: "Update campground", value: 2},
            {name: "Return to main menu", value: 3}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            dates = get_dates
            alert.update_dates(dates)
            puts "Alert updated.\n\n"
            view_alerts_menu
        elsif choice == 2
            camp = campground_search_by_name_menu
            alert.update_campground(camp)
            puts "Alert updated.\n\n"
            view_alerts_menu
        else
            main_menu
        end
    end

    def delete_alert
        alert = choose_alert
        alert.destroy
        user.alerts.reload
        puts "Alert deleted.\n\n"
        view_alerts_menu
    end
end
