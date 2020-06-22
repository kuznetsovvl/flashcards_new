# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@mail.com' }
    password { '12345' }
    password_confirmation { '12345' }
  end

  factory :authentication do
    user
    trait :github do
      provider { :github }
      uid { '12345678' }
    end
  end

  factory :image do
    image { File.new("#{Rails.root}/spec/support/test.jpg") }
  end

  trait :authenticated_through_github do
    after(:create) do |user|
      create(:authentication, :github, user: user)
    end
  end

  factory :card do
    deck
    original_text { 'Hello' }
    translated_text { 'Hola' }
    updated_at { Time.now }
    mistake_counter { '0' }
    review_time { Time.now }
    easiness { '2.5' }
    interval { '1' }
    repetitions { '0' }

    trait :card_review_later do
      review_time { Time.now + 1.day }
    end
  end

  factory :deck do
    user
    name { Faker::Name.name }
  end
end
