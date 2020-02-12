class RecArea < ActiveRecord::Base
    has_many :campgrounds
    has_many :availabilities,  through: :campgrounds

    def self.explore_rec_areas
        prompt = TTY::Prompt.new
        choices = self.all.map do |area|
            {name: area.name, value: area}
        end
        prompt.select("Choose an area!", choices)
    end
    
    def view_area
        puts "#{self.name}\n\n#{self.description}"
    end
end