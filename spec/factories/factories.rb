# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@mail.com' }
    password { '12345' }
    password_confirmation { '12345' }
  end

  factory :authentication do
<<<<<<< HEAD
    user
    trait :github do
      provider { :github }
      uid { '12345678' }
    end
  end

  trait :authenticated_through_github do
    after(:create) do |user|
      create(:authentication, :github, user: user)
    end
  end

  factory :card do
=======
>>>>>>> e753d0fa666cfee9a0454e77ce628c864f2f5eb8
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
  end

  factory :deck do
    user
    name { Faker::Name.name }
  end
end
