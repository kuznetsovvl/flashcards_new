# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'create new user' do
    before do
      visit signup_path
      find('input#user_email').set('foo@mail.com')
    end
    scenario 'successfully creates user' do
      find('input#user_password').set('12345')
      find('input#user_password_confirmation').set('12345')
      click_button 'Create User'
      expect(page).to have_content('Sign up!')
    end

    scenario 'fail to create user without password' do
      click_button 'Create User'
      expect(page).to have_content('Password can\'t be blank')
    end

    scenario 'fail to create user without password_confirmation' do
      find('input#user_password').set('12345')
      click_button 'Create User'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end

  describe 'login user' do
    let!(:user) { FactoryBot.create :user }

    before do
      visit login_path
      find('input#email').set('example@mail.com')
    end
    scenario 'wrong email or password' do
      find('input#password').set('54321')
      click_button 'Log in'
      expect(page).to have_content('Email or password was invalid')
    end
  end
end
