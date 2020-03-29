# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OauthsController, type: :controller do
  describe 'GET #oauth' do
    it 'returns http success' do
      get :oauth, params: { provider: 'github' }
      expect(response).to redirect_to('https://github.com/login/oauth/authorize?client_id=cd5cce5cecb001da9a3c&display&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Foauth%2Fcallback%3Fprovider%3Dgithub&response_type=code&scope=&state')
    end
  end

  describe 'POST #callback' do
    let(:uid) { '777' }
    let(:email) { 'user@email.com' }
    let(:oauth_params) do
      {
        code: '123',
        provider: 'github'
      }
    end

    before do
      allow_any_instance_of(described_class)
        .to receive(:login_from)
        .with(any_args).and_return(user)
    end

    context 'user was not authenticated previously' do
      let(:user) { nil }

      before do
        allow_any_instance_of(described_class)
          .to receive(:create_from)
          .with('github').and_return(create(:user, :authenticated_through_github))
      end

      context 'github email is public' do
        let(:email) { 'user@email.com' }

        it 'creates new user' do
          post :callback, params: oauth_params
          expect(assigns(:user)).not_to be_nil
        end
      end

      context 'email is not available' do
        let(:email) { nil }

        it 'redirects to bootcamp root' do
          post :callback, params: oauth_params
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'user was previously authenticated' do
      let(:user) { create(:user, :authenticated_through_github) }

      it 'does not create new user' do
        expect { post :callback, params: oauth_params }
          .not_to change(User, :count)
      end
    end
  end
end
