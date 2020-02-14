class Menu
    attr_accessor :user

    def run
        welcome_banner
        self.user = User.prompt_for_user
        main_menu
    end

    def welcome_banner

        puts "\n\n"
        puts"     ,gggg, "                                                                            
        puts"   ,88*Y8b,    "                                                                       
        puts"  d8*     `Y8      "                                                                     
        puts" d8'   8b  d8                                             gg   "                       
        puts",8I    *Y88P'                                             *                     "       
        puts"I8'             ,gggg,gg   ,ggg,,ggg,,ggg,   gg,gggg,     gg    ,ggg,,ggg,     ,gggg,gg "
        puts"d8             dP*  *Y8I  ,8* *8P* *8P* *8,  I8P*  *Yb    88   ,8* *8P* *8,   dP*  *Y8I "
        puts"Y8,           i8'    ,8I  I8   8I   8I   8I  I8'    ,8i   88   I8   8I   8I  i8'    ,8I "
        puts"`Yba,,_____, ,d8,   ,d8b,,dP   8I   8I   Yb,,I8 _  ,d8' _,88,_,dP   8I   Yb,,d8,   ,d8I "
        puts"  `*Y8888888 P*Y8888P*`Y88P'   8I   8I   `Y8PI8 YY88888P8P*Y88P'   8I   `Y8P*Y8888P*888"
        puts"                                             I8                                    ,d8I'"
        puts"                                             I8                                  ,dP'8I "
        puts"                                             I8                                 ,8*  8I "
        puts"                                             I8                                 I8   8I "
        puts"                                             I8                                 `8, ,8I "
        puts"                                             I8                                  `Y8P*  "
        puts"                                                     ,gggg,             ,ggg,           "
        puts"                                                   ,88*Y8b,            dP*8I      "     
        puts"                                                  d8*     `Y8         dP   88      "     
        puts"                                                 d8'   8b  d8        dP    88      "     
        puts"                                                ,8I    *Y88P'       ,8'    88       "    
        puts"      Welcome to the Camping CA!                I8'                 d88888888       "    
        puts"                                                d8            __   ,8*     88         "  
        puts"    Where you can explore all nine of           Y8,          dP*  ,8P      Y8    "       
        puts"      California's National Parks!              `Yba,,_____, Yb,_,dP       `8b,    "     
        puts"                                                  `*Y8888888  *Y8P*         `Y8     "    
        puts "\n\n"
    end

    def main_menu
        prompt = TTY::Prompt.new
        choices = [
            {name: 'Explore National Parks', value: 1},
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
            puts "Thanks for exploring! Goodbye!\n\n"
            exit
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
            {name: "Return to view parks", value: 2},
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
            {name: "View description", value: 1},
            {name: "View availability", value: 2},
            {name: "View more campgrounds of #{camp.rec_area.name}", value: 3},
            {name: "Search for campgrounds by name", value: 4},
            {name: "Return to main menu", value: 5}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            camp.view_description
            puts "\n\n"
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

    def campground_search_by_name_menu
        prompt = TTY::Prompt.new
        camp_name = prompt.ask("Enter a campground name to search, 'menu' to return to the main menu:") do |input|
            input.modify :trim, :up
        end
        puts "\n\n"
        if camp_name == "MENU"
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
        begin
            start_prompt = TTY::Prompt.new
            start_date = start_prompt.ask("Enter your arrival date: (within the next month, MM/DD)", convert: :date)
            end_prompt = TTY::Prompt.new
            end_date = end_prompt.ask("Enter your departure date: (within the next month, MM/DD", convert: :date)
            puts "\n\n"
            if end_date < start_date || end_date > Date.today.next_month
                puts "Invalid dates. Please try again."
                get_dates
            else    
                [start_date, end_date]
            end
        rescue
            puts "Oops! There was a problem with the date that you entered. Please try again!"
            get_dates
        end
    end

    def print_availability(camp, start_date, end_date)
        avail_array = camp.check_availability(start_date, end_date)
        puts "Sites available for #{camp.name}:"
        table = TTY::Table.new header: ['Date','# Available']
        avail_array.each do |hash|
            table << [hash[:date], hash[:avail]]
        end
        puts table.render :unicode, alignment: [:center]
        puts "\n\n"
        prompt = TTY::Prompt.new
        open_browser = prompt.yes?("Would you like to open recreation.gov to reserve?")
        puts "\n\n"
        if open_browser
            system("open https://www.recreation.gov/camping/campgrounds/#{camp.official_facility_id}/availability")
        end
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
                {name: "Add an alert", value: 3},
                {name: "Return to main menu", value: 4}
            ]
            choice = prompt.select("Select an option:", choices)
            puts "\n\n"
            if choice == 1
                update_alert
            elsif choice == 2
                delete_alert
            elsif choice == 3
                availability_menu
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
