require 'rails_helper'

RSpec.describe Coordinates do
  it 'exists', :vcr do
    data = { results:
      [ locations: [
         { latLng: {
           :lat=> 39.738453,
           :lng=> -104.984853
        }
      }]]}
    coord = Coordinates.new(data)

    expect(coord.lat).to eq(39.738453)
    expect(coord.lng).to eq(-104.984853)
  end
end
