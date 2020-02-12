class RecArea < ActiveRecord::Base
    has_many :campgrounds
    has_many :availabilities,  through: :campgrounds

    def self.all_rec_areas
        self.all.map do |area|
            {name: area.name, value: area}
        end
    end
    
    def view_area
        puts "#{self.name}\n\n#{self.description}\n\n"
    end

    def view_campgrounds
        self.campgrounds.map do |camp|
            {name: camp.name, value: camp}
        end
    end
end