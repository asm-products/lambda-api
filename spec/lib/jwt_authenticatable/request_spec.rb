require 'rails_helper'

describe JwtAuthenticatable, type: :request do
  let(:authenticated_path) { '/categories' }
  let(:user) { create :user }
  let(:token) { user.new_jwt }

  it 'gives an error when authorization header is not set' do
    get authenticated_path, format: :json
    expect(response.code).to eq('401')
  end

  it 'gives an error when the token is not valid' do
    get authenticated_path, { format: :json }, 'Authorization' => 'Token invalidtoken'
    expect(response.code).to eq('401')
  end

  it 'authenticated when the token is valid' do
    get authenticated_path, { format: :json }, 'Authorization' => "Token #{token}"
    expect(response.code).to eq('200')
  end

  it 'returns a new token' do
    get authenticated_path, { format: :json }, 'Authorization' => "Token #{token}"
    returned_token = response.headers['X-User-JWT']
    expect(User.from_jwt(returned_token)).to eq(user)
  end
end
