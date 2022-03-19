require 'rails_helper'

RSpec.describe 'Discover index page' do
  xit "checks for description of page" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com')
    visit "/users/#{user_1.id}/discover"
    expect(page).to have_content("Discover Movies")
  end

  xit "check for top rated movies button" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com')
    visit "/users/#{user_1.id}/discover"
    expect(page).to have_button("Find Top Rated Movies")
  end
end
