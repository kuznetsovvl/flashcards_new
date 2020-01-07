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
    context 'with valid attributes' do
      let!(:user) { create(:user) }
      let(:password) { '12345' }
      it 'successfully create a session' do
        post :create, params: { email: user.email, password: password }
        expect(response.status).to eq(302)
      end

      it 'redirect the session to the root_url' do
        post :create, params: { email: user.email, password: password }
        expect(response).to redirect_to root_path
      end
    end
    context 'with invalid attributes' do
      let!(:user) { create(:user) }
      let(:password) { 'wrongpassword' }
      it 'fail create a session' do
        post :create, params: { email: user.email, password: password }
        expect(response.status).to eq(200)
      end

      it 'redirect the session to the new' do
        post :create, params: { email: user.email, password: password }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:attrs) { attributes_for :user }
    it 'successfully delete a session' do
      expect do
        login_user(user)
        delete :destroy
        response.to redirect_to root_url
      end
    end
  end
end
