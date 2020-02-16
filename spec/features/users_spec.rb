# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'create new user' do
    before do
      visit '/users/new'
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

  describe 'update user' do
    let!(:user) { FactoryBot.create :user }
    before do
      visit edit_user_path(user)
    end
    scenario 'successfuly update user' do
      find('input#user_email').set('test@mail.com')
      find('input#user_password').set('54321')
      find('input#user_password_confirmation').set('54321')
      click_button 'Update User'
      expect(page).to have_content('The user has updated successfully')
    end

    scenario 'fail to update user' do
      find('input#user_email').set('test@mail.com')
      find('input#user_password').set('54321')
      click_button 'Update User'
      expect(page).to have_content('Could not update the user')
    end
  end

  describe 'login user' do
    let!(:user) { FactoryBot.create :user }

    before do
      visit '/sessions/new'
      find('input#email').set('example@mail.com')
    end
    scenario 'wrong email or password' do
      find('input#password').set('54321')
      within('.actions') do
        click_button 'Log in'
      end
      expect(page).to have_content('Email or password was invalid')
    end
  end
end
