class Favorite < ActiveRecord::Base
    belongs_to :campground
    belongs_to :user
end