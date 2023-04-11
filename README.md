## Technologies Used

* Rails 7
* Ruby 3.1.4
* Google Directions API
* RestClient
* will_paginate
* RSpec

## Setup

* Clone the GitHub repository: https://github.com/mellowmorgan/hopskip_app.git
* From the main project directory, enter `bundle install` in the terminal to populate gems.
* To create a database and seed, type in your terminal (will also seed test database for rspec): 
      `rake db:setup`
* Run local server rails s
* Run tests with command bundle exec rspec spec/requests/driver_spec.rb
* Go to url such as "localhost:3000/driver/1" 

## Endpoints Drivers Api

|Usage | METHOD       | URL       | Params |
| :--------|:------------| :---------| :------|
|See all rides for a given driver (paginated) | GET    | `localhost:3000/api/v1/dogs?page=PAGE_NUMBER&limit=PER_PAGE` |
|See all rides for a given driver (unpaginated) | GET    | `localhost:3000/api/v1/drivers/:id` | 


## Sample Response

Expect the response for above endpoints to look like...

```
{
  "driverId": 1,
  "driverHomeAddress: "43 S Broadway, Los Angeles, CA 90013",
  "rides": [
    {
      "rideId": 11,
      "rideScore": 1009.87,
      "rideEarnings": "$2120.73",
      "rideDistance": "157.6 mi",
      "rideDurations": "0.3 hr",
      "rideStartAddress": "1533 Sunset Blvd, Los Angeles, CA 90026",
      "rideEndAddress": "453 South Spring Street Ground Floor, 121 E 5th St SUITE 505, Los Angeles, CA 90013"
    }]
}
```

## Status Codes

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 404 | `NOT FOUND` |
