# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
		let(:attrs) { attributes_for :user }

  	it 'successfully create a session' do
  		session[:user_id].should be_nil
  		post :create, params: { email: 'example', password: '12345'}, session: {'user_id' => 1}
  		session[:user_id].should_not be_nil
  	end

  	it 'redirect the user to the root_url' do
  		post :create, params: { user: attrs }
  		expect(response).to redirect_to root_path
  	end
  end
end
