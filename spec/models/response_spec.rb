require 'rails_helper'

describe Response, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:answer).inverse_of(:responses) }
    it { is_expected.to belong_to(:question).inverse_of(:responses) }
    it { is_expected.to belong_to(:round).inverse_of(:responses) }
    it { is_expected.to belong_to(:user).inverse_of(:responses) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }
    it { is_expected.to validate_presence_of(:round) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
