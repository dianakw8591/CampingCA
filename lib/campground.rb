class Campground < ActiveRecord::Base
    belongs_to :rec_area
    has_many :availabilities
    has_many :alerts
    has_many :users,  through: :alerts

    def self.find_by_name(name)
        self.find_by(name: name)
    end

    # get data for availability by date
    # def update_availability(start_date, end_date)
    #     # query rec.gov for campsites
    #     #update availability records in database
    # end

    def check_availability(start_date, end_date)
        date_range = []
        date = start_date
        while date < end_date do
            date_range << date
            date = date.next
        end
        date_range.map do |date|
            {date: date,
            avail: sites_available_on_date(date)}
        end
    end

    def sites_available_on_date(date)
        instance = availabilities.find_by(date: date)
        instance.sites_available
    end

    def set_alert(date_array, user)
        Alert.create(user_id: user.id, campground_id: self.id, start_date: date_array[0], end_date: date_array[1])
        user.alerts.reload
    end

    def view_description
        puts Sanitize.fragment(description)
    end
end