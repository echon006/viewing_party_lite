require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists', :vcr do
    start_location = "Denver,CO"
    destination = "Boulder,CO"
    coord = CoordinatesFacade.get_coord(destination)
    weather_data = WeatherService.get_weather(coord.lat, coord.lng)
    route = RoadTripService.find_route(start_location, destination)

    route = RoadTrip.new(route, weather_data, start_location, destination)

    expect(route.start_city).to be_a String
    expect(route.end_city).to be_an String
    expect(route.travel_time).to be_an String
    expect(route.weather_at_eta).to be_an Hash
  end
end 
