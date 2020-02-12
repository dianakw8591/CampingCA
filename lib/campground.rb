class Campground < ActiveRecord::Base
    belongs_to :rec_area
    has_many :availabilities
    has_many :favorites
    has_many :users,  through: :favorites

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