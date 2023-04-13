class Driver < ApplicationRecord
  validates :home_address, presence: true
  def get_all_rides_scores
    rides = Ride.all
    driver_rides = []
    
    rides.each do |ride|
      start_address = ride.start_address
      end_address = ride.end_address

      commute_distance, commute_duration = directions_api.get_maps_info(home_address, start_address).values_at(:distance, :duration)
      
      # Assuming database has been updated recently and has those values, use database and not api
      if ride.distance.nil? || ride.duration.nil? || (ride.duration.present? && ride.distance.present? && ride.updated_at < 2.minutes.ago)
        ride_distance, ride_duration = directions_api.get_maps_info(start_address, end_address).values_at(:distance, :duration)
        ride.update!(duration: ride_duration, distance: ride_distance)
      else
        ride_distance = ride.distance
        ride_duration = ride.duration
      end
      earnings = ride_earnings(ride_duration, ride_distance)
      score = ride_score(earnings, commute_duration, ride_duration)
      
      driver_rides <<    { 
        ride_id: ride.id,
        ride_score: score,
        ride_earnings: '$' + earnings.round(2).to_s,
        ride_distance: ride_distance.to_s + ' mi',
        ride_duration: ride_duration.to_s + ' hr',
        ride_start_address: start_address,
        ride_end_address: end_address
    }
    end
    driver_rides
  end

  private 

  # Ride earnings is how much driver earns by driving the ride. Takes into account amount of time is expected and distance. 
  # It is calculated as: $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes
  def ride_earnings(duration, distance)
    total = 0
    distance_over_five_miles = distance-5
    if distance_over_five_miles > 0
      total += distance_over_five_miles*(13.50)
      distance = 5
    end
    total += distance * 12.0
    duration_to_minutes = duration * 60
    beyond_fifteen_minutes = duration_to_minutes - 15
    beyond_calc = beyond_fifteen_minutes > 0 ? (0.70 * beyond_fifteen_minutes) : 1
    total = total + (duration) * beyond_calc
  end

  # Ride score is (ride earnings) / (commute duration + ride duration)
  def ride_score(earnings, commute_duration, ride_duration)
    (earnings / (commute_duration + ride_duration)).round(2)
  end

  def directions_api
    @directions_api ||= DirectionsApi.new
  end
end
