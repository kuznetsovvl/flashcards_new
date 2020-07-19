# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'create new user' do
    before do
      visit 'users/new'
      find('input#user_email').set('foo@mail.com')
    end
    scenario 'successfully creates user' do
      find('input#user_password').set('12345')
      find('input#user_password_confirmation').set('12345')
      expect { click_button 'Create User' }.to change(User, :count).by(1)
    end

    scenario 'fail to create user without password' do
      expect { click_button 'Create User' }.to change(User, :count).by(0)
    end

    scenario 'fail to create user without password_confirmation' do
      find('input#user_password').set('12345')
      expect { click_button 'Create User' }.to change(User, :count).by(0)
    end
  end

  describe 'update user password' do
    let!(:user) { create :user }
    before do
      visit edit_password_user_path(user)
    end
    scenario 'successfuly update password' do
      find('input#user_password').set('54321')
      find('input#user_password_confirmation').set('54321')
      click_button I18n.t('buttons.update')
      expect(page).to have_content(I18n.t('users.update.success'))
    end

    scenario 'fail to update password' do
      find('input#user_password').set('54321')
      click_button I18n.t('buttons.update')
      expect(current_path).to eql(user_path(user))
    end
  end

  describe 'login user' do
    let!(:user) { create :user }

    before do
      visit '/sessions/new'
      find('input#login_email').set('example@mail.com')
    end
    scenario 'wrong email or password' do
      find('input#login_password').set('54321')
      click_button I18n.t('buttons.login').to_s
      expect(page).to have_content(I18n.t('sessions.create.error'))
    end
  end
end
