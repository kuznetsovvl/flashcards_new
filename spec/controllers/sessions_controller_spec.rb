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
    let(:attrs) { { email: 'example', password: '12345' } }
    let!(:user) { create(:user) }
    it 'successfully create a session' do
      expect do
        post :create, params: { user: attrs }
        response.status.to eq(302)
      end
    end

    it 'redirect the session to the root_url' do
      expect do
        post :create, params: { user: attrs }
        response.to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:attrs) { { email: 'example', password: '12345' } }
    it 'successfully delete a session' do
      expect do
        post :create, params: { user: attrs }
        delete :destroy
        response.to redirect_to root_url
      end
    end
  end
end
