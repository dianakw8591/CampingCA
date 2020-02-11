require_relative 'config/environment.rb'

di = User.create(name: "Diana", email: "dianakw@gmail.com")
yos = RecArea.create(name: "Yosemite", state_code: "CA", description: "The best!")
pines = Campground.new(name: "Lower Pines")
fav = Favorite.create(user_id: 1, campground_id: 1)
a = Availability.create(date: "2020-02-10")
