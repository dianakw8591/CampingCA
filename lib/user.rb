class User < ActiveRecord::Base
    has_many :favorites
    has_many :campgrounds,  through: :favorites 
end