# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Current User', type: :feature do
  describe 'Change locale' do
    let!(:user) { create :user }
    before do
      login_scenario
      visit edit_user_path(user)
    end

    it 'should change locale to russian' do
      select I18n.t('users.edit.languages.ru'), from: 'user_locale'
      click_button I18n.t('buttons.update')
      expect(I18n.locale).to eq(:ru)
    end

    it 'should change locale to english' do
      select I18n.t('users.edit.languages.en'), from: 'user_locale'
      click_button I18n.t('buttons.update')
      expect(I18n.locale).to eq(:en)
    end
  end

  def login_scenario
    visit '/sessions/new'
    find('input#login_email').set('example@mail.com')
    find('input#login_password').set('12345')
    click_button I18n.t('buttons.login').to_s
  end
end
