# di = User.create(name: "Diana", email: "dianakw@gmail.com")
# yos = RecArea.create(name: "Yosemite", state_code: "CA", description: "The best!")
# pines = Campground.new(name: "Lower Pines")
# fav = Favorite.create(user_id: 1, campground_id: 1)
# a = Availability.create(date: "2020-02-10")


require 'net/http'
require 'open-uri'
require 'json'

RecArea.delete_all
 
# yosemite = "https://ridb.recreation.gov/api/v1/recareas/2991"
# upper_pines =   "https://ridb.recreation.gov/api/v1/facilities/232447"

rec_codes = ["2991", "2782", "2931", "2662"]
# https://ridb.recreation.gov/api/v1/recareas/2991/facilities where 2991 is recarea id
# "ParentRecAreaID": "2991",
#             "FacilityName": "Camp 4",
#               "FacilityID"
#             "FacilityDescription":
# "FacilityTypeDescription": "Campground",
# ["RECDATE"][array_num]["FacilityName"...etc]

def get_request_for_rec_data(url)
    RestClient::Request.execute(method: :get, 
    url: url,
    headers: {
        apiKey: ENV['API_KEY']
        }
    )
end

def parse_json(url)
    JSON.parse(get_request_for_rec_data(url))
end

def seed_rec_area_row(rec_hash)
    name = rec_hash["RecAreaName"]
    id = rec_hash["RecAreaID"]
    description = rec_hash["RecAreaDescription"]
    RecArea.create(name: name, official_rec_area_id: id, description: description)
end

def populate_rec_table(id_array)
    base_url = "https://ridb.recreation.gov/api/v1/recareas/"
    id_array.each do |id|
        url = base_url + id
        rec_hash = parse_json(url)
        seed_rec_area_row(rec_hash)
    end
end

populate_rec_table(rec_codes)


# yos = parse_json(yosemite)
# seed_rec_area_row(yos)


# binding.pry
