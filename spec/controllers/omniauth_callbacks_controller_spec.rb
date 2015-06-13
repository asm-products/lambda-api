require 'rails_helper'

describe OmniauthCallbacksController, type: :controller do
  before do
    request.env['omniauth.auth'] = auth_hash
  end

  %w(google_oauth2 facebook_access_token).each do |provider|
    describe provider do
      let(:user) { create "#{provider}_user".to_sym }
      let(:auth_hash) do
        {
          'provider' => provider,
          'uid' => SecureRandom.uuid,
          'info' => {
            'name' => user.email,
            'email' => user.email
          }
        }
      end

      it 'create users from the auth hash' do
        expect(User).to receive(:from_omniauth).with(auth_hash).and_return(user)
        get provider.to_sym
      end
    end
  end
end
