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
    let!(:user) { create(:user) }

    context 'with valid attributes' do
      before do
        post :create, params: { login: { email: user.email, password: '12345' } }
      end

      it 'successfully create a session' do
        expect(logged_in?).to eq true
      end

      it 'redirect the session to the root_url' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      before do
        post :create, params: { login: { email: user.email, password: 'wrongpassword' } }
      end

      it 'fail create a session' do
        expect(logged_in?).to eq false
      end

      it 'redirect the session to the new' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }
    before do
      login_user(user)
      delete :destroy
    end

    it 'successfully delete a session' do
      expect(logged_in?).to eq false
    end

    it 'redirect the session to the root_url' do
      expect(response).to redirect_to root_path
    end
  end
end
