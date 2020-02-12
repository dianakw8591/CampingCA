class RecArea < ActiveRecord::Base
    has_many :campgrounds
    has_many :availabilities,  through: :campgrounds

    def self.explore_rec_areas(menu, user)
        prompt = TTY::Prompt.new
        choices = self.all.map do |area|
            {name: area.name, value: area}
        end
        choices << {name: "Return to main menu", value: 1}
        choice = prompt.select("Choose an area!", choices)
        puts "\n\n"
        if choice == 1
            menu.main_menu(user)
        else choice.view_area(menu, user)
        end
    end
    
    def view_area(menu, user)
        prompt = TTY::Prompt.new
        puts "#{self.name}\n\n#{self.description}\n\n"
        choices = [
            {name: "View campgrounds", value: 1},
            {name: "Return to view areas", value: 2},
            {name: "Return to main menu", value: 3}
        ]
        choice = prompt.select("Select an option:", choices)
        puts "\n\n"
        if choice == 1
            self.view_campgrounds(menu, user)
        elsif choice == 2
            RecArea.explore_rec_areas(menu, user)
        else
            menu.main_menu(user)
        end
    end

    def view_campgrounds(menu, user)
        prompt = TTY::Prompt.new
        choices = self.campgrounds.map do |camp|
            {name: camp.name, value: camp}
        end
        choices << {name: "Return to area", value: 1}
        choices << {name: "Return to main menu", value: 2}
        choice = prompt.select("Select a campground to view details", choices)
        puts "\n\n"
        if choice == 1
            self.view_area(menu, user)
        elsif choice == 2
            menu.main_menu(user)
        else choice.view_campground_details(menu, user)
        end
    end
end