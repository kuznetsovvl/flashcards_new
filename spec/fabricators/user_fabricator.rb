# frozen_string_literal: true

Fabricator (:user) do
  email { 'example@mail.com' }
  password { '12345' }
  password_confirmation { '12345' }
end
