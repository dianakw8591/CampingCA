class Campground < ActiveRecord::Base
    belongs_to :rec_area
    has_many :availabilities
    has_many :alerts
    has_many :users,  through: :alerts

    def view_campground_details(menu, user)
        prompt = TTY::Prompt.new
        puts "#{self.name}\n\n"
        choices = [
            {name: "View description", value: 1},
            {name: "View availability", value: 2},
            {name: "Return to campgrounds", value: 3},
            {name: "Return to main menu", value: 4}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            puts "#{self.description}\n\n"
            view_campground_details(menu, user)
        elsif choice == 2
            self.dates_for_availability(menu, user)
        elsif choice == 3
            self.rec_area.view_campgrounds(menu, user)
        else
            menu.main_menu(user)
        end
    end

    def dates_for_availability(menu, user)
    end

    # get data for availability by date
    def update_availability(start_date, end_date)
        # query rec.gov for campsites
        #update availability records in database
    end

    def check_availability(start_date, end_date)
    end

    def sites_available_on_date(date)
        availabilities.find_by
    end

    def set_alert_for_dates(start_date, end_date)
    end

end