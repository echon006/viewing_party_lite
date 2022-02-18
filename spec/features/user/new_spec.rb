require 'rails_helper'

RSpec.describe 'User new page' do

  it 'has a form for new users' do
    visit register_path

    fill_in("Name", with: "Name_1")
    fill_in("Email", with: "Name_1@email.com")
    fill_in("Password", with: "hello123")
    fill_in("Password confirmation", with: "hello123")

    click_button "Register"
    expected = User.last
    expect(current_path).to eq("/dashboard")
    # expect(flash[:success]).to be_present
  end

  describe 'invalid forms show flash error ' do
    it 'name missing' do
      visit register_path

      fill_in("Email", with: "Name_1@email.com")
      fill_in("Password", with: "hello123")
      fill_in("Password confirmation", with: "hello123")

      click_button "Register"

      expected = User.last

      expect(page).to have_content("Error name missing!")
      expect(expected).to eq(nil)
    end

    it 'email missing' do
      visit register_path


      fill_in("Name", with: "Name_1")
      fill_in("Password", with: "hello123")
      fill_in("Password confirmation", with: "hello123")

      click_button "Register"

      expected = User.last

      expect(page).to have_content("Error email missing!")
      expect(expected).to eq(nil)
    end

    it 'passswords not matching' do
      visit register_path

      fill_in("Name", with: "Name_1")
      fill_in("Email", with: "Name_1@email.com")

      fill_in("Password", with: "hello123")
      fill_in("Password confirmation", with: "hello124")

      click_button "Register"

      expected = User.last

      expect(expected).to eq(nil)
    end
  end
end
