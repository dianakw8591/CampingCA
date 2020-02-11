class Campground < ActiveRecord::Base
    belongs_to :rec_area
    has_many :availabilities
    has_many :favorites
    has_many :users,  through: :favorites
end