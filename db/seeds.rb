# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

home_addresses = ["8284 Melrose Ave, Los Angeles, CA 90046", "4507 S Centinela Ave, Los Angeles, CA 90066", "4319 Sunset Blvd, Los Angeles, CA 90029", "692 N Robertson Blvd, West Hollywood, CA 90069", "8265 Beverly Blvd, Los Angeles, CA 90048"]

start_addresses = ["8301 Beverly Blvd, Los Angeles, CA 90048", "8274 Santa Monica Blvd, West Hollywood, CA 90046", "543 S Broadway, Los Angeles, CA 90013", "1533 Sunset Blvd, Los Angeles, CA 90026"]
end_addresses = ["7575 Beverly Blvd, Los Angeles, CA 90063", "453 South Spring Street Ground Floor, 121 E 5th St SUITE 505, Los Angeles, CA 90013", "1200 Getty Center Dr, Los Angeles, CA 90049"]

home_addresses.each { |address| Driver.create!(home_address: address) }

start_addresses.each { |start_address|
    end_addresses.each {|end_address| 
      Ride.create!(start_address: start_address, end_address: end_address)
  }
}