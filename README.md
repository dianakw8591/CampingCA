# Camping CA

Camping CA is a CLI application used a explore National Parks in California and view camping availability in those parks.

A user of Camping CA can:

-Create an account with name and email  
-Update their name and email  
-Delete their account  
-View information about the parks and their campgrounds  
-Search camping availability (currently fake data) given a campground and date range  
-Set an alert on a given seach that will (theoretically) send an email if camping   becomes available for that search  
-Update the alert criteria  
-Delete an alert  

## Installation

  Download or clone the repository, then run 'bundle install' to install required gems.
  ```
  bundle install
  ```
  To obtain an APIKey, go [recreation.gov](https://www.recreation.gov/sign-up) to create an account. Then sign in [here](https://ridb.recreation.gov/login) and go to your profile in the top right corner. There you can generate a new APIKey.

  Create a file named '.env' in the root directory. In this file, paste your APIKey following `API_KEY=` like so:
  ```
  API_KEY=your_api_key_generated_from_ridb.recreation.gov
  ```
  Run 'rake db:migrate' in the root directory to create the database locally.
  ```
  rake db:migrate
  ```
  Run 'rake db:seed` to seed the database.
  ```
  rake db:seed
  ```
  Then run 'ruby bin/run.rb' to enter the explorer!
  ```
  ruby bin/run.rb
  ```

## Contributing

Contributions are welcome. Feel free to open a pull request or branch from this project.

## Data

Data source: ridb.recreation.gov

## License

[MIT](https://choosealicense.com/licenses/mit/)

