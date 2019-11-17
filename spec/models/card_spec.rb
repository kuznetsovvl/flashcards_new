require 'rails_helper'

RSpec.describe Card, type: :model do
  it "validate with valid original_text and translated_text" do
    expect(Card.new(original_text: "anything", translated_text: "anything_text")).to be_valid
  end

  it "should not be valid if original_text is empty" do
    expect(Card.new(original_text: nil, translated_text: "anything")).to_not be_valid
   end
   
  it "should not be valid if translated_text is empty" do
  	expect(Card.new(original_text: "anything", translated_text: nil)).to_not be_valid
  end
end
