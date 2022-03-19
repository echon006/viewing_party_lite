class UserPartiesController < ApplicationController

end



require 'rails_helper'

RSpec.describe 'Users API' do

  it 'creates a user and generates unique api key associated with user' do
    user_info = {
                email: 'test_1@email.com',
                password: 'password_1',
                password_confirmation: 'password_1'
                }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

    created_user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(created_user).to have_key(:data)
    expect(created_user[:data][:type]).to eq("users")
    expect(created_user[:data][:attributes]).to have_key(:email)
    expect(created_user[:data][:attributes]).to have_key(:private_api_key)
  end
end
