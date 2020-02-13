class Alert < ActiveRecord::Base
    belongs_to :campground
    belongs_to :user

    def display_alert
        puts "Alert set for #{self.campground.name} from #{self.start_date} to #{self.end_date}"
    end

    def update_dates(dates)
        self.start_date = dates[0]
        self.end_date = dates[1]
        self.save
    end

    def update_campground(camp)
        self.campground = camp
        self.save
    end

        
            
end