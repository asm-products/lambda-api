require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:auth_tokens) }
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
end
