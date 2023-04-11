class DirectionsApi

  GOOGLE_DIRECTIONS_API_KEY = "AIzaSyCHhokqzuASTDDOnVEsNpqvwTKgrxErF20"
  RESOURCE = 'https://maps.googleapis.com/maps/api/directions/json?'

  # Returns hash with distance and duration keys
  def get_maps_info(origin, destination)
    origin = url_encode(destination)
    destination = url_encode(destination)
    url = "#{RESOURCE}origin=#{origin}&destination=#{destination}&key=#{GOOGLE_DIRECTIONS_API_KEY}"
    response = RestClient::Request.execute(method: :get, url: url)
    if response.body.present?
      body = JSON.parse(response.body)
      # response is {"text"=>"45 mins", "value"=>2679} convert to hours
      # response is {"text"=>"35.1 mi", "value"=>56518} # strip out mi
      distance = body.dig('routes',0,'legs',0,'distance','value')
      duration = body.dig('routes',0,'legs',0,'duration','value')
      {
        distance: convert_google_distance(distance),
        duration: convert_google_duration(duration)
      }
    end
  end

  # To test without making api calls...but emulating result
  def dummy_data(origin, destination)
    {distance: rand(0.1..199).round(1), duration:rand(0.1..4).round(1)}
  end

  private

  # Returns distance in miles in float format
  def convert_google_distance(distance)
    distance.gsub(' mi', '').to_f
  end

  # Returns duration in hours in float format
  def convert_google_duration(duration)
    durations_arr = duration.split
    case durations_arr.size
    when 2 && durations_arr[1].include?("hour")
      durations_arr[0]
    when 2 && durations_arr[1].include?("min")
      durations_arr[0].to_f/60
    when 4
      durations_arr[0].to_i + (durations_arr[3].to_f/60)
    end
  end
  
  def url_encode(address)
    address.gsub(' ', '+')
  end 
end