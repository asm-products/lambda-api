require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:auth_tokens).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'defaults' do
    subject { create :user }

    its(:first_name) { is_expected.to be_present }
    its(:last_name) { is_expected.to be_present }
    its(:auth_tokens) { is_expected.to be_present }
  end

  describe '.from_omniauth' do
    let(:attrs) { attributes_for(:google_oauth2_user) }
    let(:auth_hash) do
      {
        'provider' => attrs[:provider],
        'uid' => attrs[:uid],
        'info' => {
          'name' => "#{attrs[:first_name]} #{attrs[:last_name]}",
          'email' => attrs[:email],
          'first_name' => attrs[:first_name],
          'last_name' => attrs[:last_name]
        }
      }
    end

    subject { User.from_omniauth(auth_hash) }

    context 'returning user' do
      it 'finds existing user' do
        create :user # other users
        user = create :user, attrs
        create :user # other users
        expect(subject).to eq(user)
      end
    end

    context 'new user' do
      it 'create a new user' do
        expect { subject }.to change { User.count }.by(1)
      end

      its(:email) { is_expected.to eq(attrs[:email]) }
      its(:first_name) { is_expected.to eq(attrs[:first_name]) }
      its(:last_name) { is_expected.to eq(attrs[:last_name]) }
    end
  end

end
