require 'rails_helper'

RSpec.describe 'Landing index page' do

  it 'has title of application' do
    visit '/'
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has button to create new user' do
    visit '/'
    click_button 'Create new user'
    expect(current_path).to eq(register_path)
  end

  xit "has list of existing users" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com')
    user_2 = User.create!(name: 'User 2', email: 'email2@gmail.com')
    user_3 = User.create!(name: 'User 3', email: 'email3@gmail.com')
    visit root_path
    expect(page).to have_content("#{user_1.email}'s Dashboard")
    expect(page).to have_content("#{user_2.email}'s Dashboard")
    expect(page).to have_content("#{user_3.email}'s Dashboard")
  end

  xit "has list of existing users as links" do
    user_1 = User.create!(name: 'User 1', email: 'email1@gmail.com')
    user_2 = User.create!(name: 'User 2', email: 'email2@gmail.com')
    user_3 = User.create!(name: 'User 3', email: 'email3@gmail.com')
    visit root_path
    click_link("#{user_1.email}'s Dashboard")
    expect(current_path).to eq(user_path(user_1))
  end


  it "has link to return to landing page" do
    visit '/'
    click_link 'Home'
    expect(current_path).to eq('/')
  end

  it "has link to log in page" do
    visit '/'
    click_link 'Log In'
    expect(current_path).to eq('/login')
  end

end
