# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    original_text { 'Hello' }
    translated_text { 'Hola' }
    updated_at { Time.now }

    # factory :old_one do
    #   updated_at { 10.days.ago }
    # end
  end
end
