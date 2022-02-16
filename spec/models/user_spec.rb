require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:password_confirmation)}
  end

  describe "relations" do
    it { should have_many(:user_parties)}
    it { should have_many(:parties).through(:user_parties)}
  end

  it 'has a form for new users' do
    visit register_path

    fill_in("Name", with: "Name_1")
    fill_in("Email", with: "Name_1@email.com")
    fill_in("Password", with: "hello123")
    fill_in("Password confirmation", with: "hello123")

    click_button "Register"
    expected = User.last
    expect(current_path).to eq("/users/#{expected.id}")
  end
end
