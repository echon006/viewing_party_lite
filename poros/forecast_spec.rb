require 'rails_helper'

RSpec.describe Forecast do
  it 'exits' do
    data = { current: {
        dt: 1, sunrise: 2, sunset: 3, temp: 4.5, feels_like: 6.7,
        humidity: 89, uvi: 10.11, visibility: 12, weather: [{
          conditions: "condition 1", icon: "icon 1"}
          ]},
            hourly: [
              {dt: 1, temp: 23.45, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, temp: 54.32, weather: [{description: "description 2", icon: "icon 2"}]}
            ],
            daily: [
              {dt: 1, sunrise: 2, sunset: 3, temp: {min: 45.6, max: 78.90}, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, sunrise: 3, sunset: 2, temp: {min: 65.4, max: 32.1}, weather: [{description: "description 1", icon: "icon 1"}]}
            ]
          }
    forecast = Forecast.new(data)

    expect(forecast.current_weather).to be_a Hash
    expect(forecast.daily_weather).to be_an Array
    expect(forecast.hourly_weather).to be_an Array
  end

  it "checks that current_weather has the correct keys" do
    data = { current: {
        dt: 1, sunrise: 2, sunset: 3, temp: 4.5, feels_like: 6.7,
        humidity: 89, uvi: 10.11, visibility: 12, weather: [{
          conditions: "condition 1", icon: "icon 1"}
          ]},
            hourly: [
              {dt: 1, temp: 23.45, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, temp: 54.32, weather: [{description: "description 2", icon: "icon 2"}]}
            ],
            daily: [
              {dt: 1, sunrise: 2, sunset: 3, temp: {min: 45.6, max: 78.90}, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, sunrise: 3, sunset: 2, temp: {min: 65.4, max: 32.1}, weather: [{description: "description 1", icon: "icon 1"}]}
            ]
          }
    forecast = Forecast.new(data)

    expect(forecast.current_weather).to have_key :datetime
    expect(forecast.current_weather).to have_key :sunrise
    expect(forecast.current_weather).to have_key :sunset
    expect(forecast.current_weather).to have_key :temp
    expect(forecast.current_weather).to have_key :feels_like
    expect(forecast.current_weather).to have_key :humidity
    expect(forecast.current_weather).to have_key :uvi
    expect(forecast.current_weather).to have_key :visibility
    expect(forecast.current_weather).to have_key :conditions
    expect(forecast.current_weather).to have_key :icon
  end

  it "checks that daily_weather has the correct keys" do
    data = { current: {
        dt: 1, sunrise: 2, sunset: 3, temp: 4.5, feels_like: 6.7,
        humidity: 89, uvi: 10.11, visibility: 12, weather: [{
          conditions: "condition 1", icon: "icon 1"}
          ]},
          daily: [
            {dt: 1, sunrise: 2, sunset: 3, temp: {min: 45.6, max: 78.90}, weather: [{description: "description 1", icon: "icon 1"}]},
            {dt: 2, sunrise: 3, sunset: 2, temp: {min: 65.4, max: 32.1}, weather: [{description: "description 1", icon: "icon 1"}]}
          ],
            hourly: [
              {dt: 1, temp: 23.45, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, temp: 54.32, weather: [{description: "description 2", icon: "icon 2"}]}
            ]
          }
    forecast = Forecast.new(data)

    expect(forecast.daily_weather.first).to have_key :date
    expect(forecast.daily_weather.first).to have_key :sunrise
    expect(forecast.daily_weather.first).to have_key :sunset
    expect(forecast.daily_weather.first).to have_key :max_temp
    expect(forecast.daily_weather.first).to have_key :min_temp
    expect(forecast.daily_weather.first).to have_key :conditions
    expect(forecast.daily_weather.first).to have_key :icon
  end

  it "checks that hourly_weather has the correct keys" do
    data = { current: {
        dt: 1, sunrise: 2, sunset: 3, temp: 4.5, feels_like: 6.7,
        humidity: 89, uvi: 10.11, visibility: 12, weather: [{
          conditions: "condition 1", icon: "icon 1"}
          ]},
          daily: [
            {dt: 1, sunrise: 2, sunset: 3, temp: {min: 45.6, max: 78.90}, weather: [{description: "description 1", icon: "icon 1"}]},
            {dt: 2, sunrise: 3, sunset: 2, temp: {min: 65.4, max: 32.1}, weather: [{description: "description 1", icon: "icon 1"}]}
          ],
            hourly: [
              {dt: 1, temp: 23.45, weather: [{description: "description 1", icon: "icon 1"}]},
              {dt: 2, temp: 54.32, weather: [{description: "description 2", icon: "icon 2"}]}
            ]
          }
    forecast = Forecast.new(data)
    expect(forecast.hourly_weather.first).to have_key :time
    expect(forecast.hourly_weather.first).to have_key :temp
    expect(forecast.hourly_weather.first).to have_key :conditions
    expect(forecast.hourly_weather.first).to have_key :icon
  end
end
