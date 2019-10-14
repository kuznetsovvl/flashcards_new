require 'rails_helper'

RSpec.describe Card, type: :model do
  it "validate with valid origin_text" do
  expect(Card.new(original_text: "anything", translated_text: "anything")).to be_valid
  end
end
