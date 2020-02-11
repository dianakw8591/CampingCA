class RecArea < ActiveRecord::Base
    has_many :campgrounds
    has_many :availabilities,  through: :campgrounds
end