
require 'rails_helper'

RSpec.describe 'User login page' do
  it 'checks if login works' do
    visit register_path

    fill_in("Name", with: "Name_1")
    fill_in("Email", with: "Name_1@email.com")
    fill_in("Password", with: "hello123")
    fill_in("Password confirmation", with: "hello123")

    click_button "Register"
    expected = User.last
    expect(current_path).to eq("/users/#{expected.id}")
    visit login_path


    fill_in("Email", with: "Name_1@email.com")
    fill_in("Password", with: "hello123")

    click_button "Log in"

    expect(current_path).to eq("/users/#{expected.id}")
  end

  it 'checks login fails if password is incorrect' do
    visit register_path

    fill_in("Name", with: "Name_1")
    fill_in("Email", with: "Name_1@email.com")
    fill_in("Password", with: "hello123")
    fill_in("Password confirmation", with: "hello123")

    click_button "Register"
    expected = User.last
    expect(current_path).to eq("/users/#{expected.id}")
    visit login_path

    fill_in("Email", with: "Name_1@email.com")
    fill_in :password, with: "incorrect password"

    click_on "Log in"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end
