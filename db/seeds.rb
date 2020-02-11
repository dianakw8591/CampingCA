# di = User.create(name: "Diana", email: "dianakw@gmail.com")
# yos = RecArea.create(name: "Yosemite", state_code: "CA", description: "The best!")
# pines = Campground.new(name: "Lower Pines")
# fav = Favorite.create(user_id: 1, campground_id: 1)
# a = Availability.create(date: "2020-02-10")


require 'net/http'
require 'open-uri'
require 'json'
 
class GetRequester
    attr_reader :url
    def initialize(url)
        @url = url
    end

  
  def get_response_body
    uri = URI.parse(self.url)
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def parse_json
    JSON.parse(self.get_response_body)
  end
 
end

url =   "https://ridb.recreation.gov/api/v1/facilities/232447"
r = RestClient::Request.execute(method: :get, 
  url: url,
  headers: {
    apiKey: ENV['API_KEY']
    }
)
binding.pry
