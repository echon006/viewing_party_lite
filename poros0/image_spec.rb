require 'rails_helper'

RSpec.describe Image do
  it 'exists', :vcr do
    data = { results:
      [ urls: {raw: "raw url 1"},
           user: {
           links: {self: "Image URL" },
           :name => "author 1"
        }
      ]}
    image = Image.new(data)

    expect(image.id).to eq(nil)
    expect(image.url).to eq("raw url 1")
    expect(image.credit).to have_key :source
    expect(image.credit[:source]).to eq("Image URL")
    expect(image.credit).to have_key :author
    expect(image.credit[:author]).to eq("author 1")

  end
end
