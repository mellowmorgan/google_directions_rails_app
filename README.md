# Google Directions Ride Rails API

## About

Just one endpoint for getting rides for a driver sorted by score (highest first) using Google Directions API.

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
* Run tests with command bundle exec rspec
* Go to url "localhost:3000/driver/1" 

## Endpoints Drivers Api

|Usage | METHOD       | URL       | Params |
| :--------|:------------| :---------| :------|
|See all rides for a given driver (paginated) | GET    | `localhost:3000/drivers/:id?page=PAGE_NUMBER&limit=PER_PAGE` | id, page, limit |
|See all rides for a given driver (unpaginated) | GET    | `localhost:3000/drivers/:id` | id |


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
      "rideDuration": "0.3 hr",
      "rideStartAddress": "1533 Sunset Blvd, Los Angeles, CA 90026",
      "rideEndAddress": "453 South Spring Street Ground Floor, 121 E 5th St SUITE 505, Los Angeles, CA 90013"
    }]
}
```

## Status Codes

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 400 | `BAD REQUEST` |
| 404 | `NOT FOUND` |
