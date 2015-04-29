require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'defaults' do
    let(:now) { Time.now }

    subject { create :auth_token, :mock_relations, created_at: now }

    its(:user_id) { is_expected.to be_present }
    its(:token) { is_expected.to be_present }
    its(:expires_at) { is_expected.to eq(now + 2.weeks) }
  end
end
