require 'rails_helper'

describe Round, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:game).inverse_of(:rounds) }
    it { is_expected.to have_many(:responses).inverse_of(:round)
         .dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:game) }
    it { is_expected.to validate_presence_of(:p1_score) }
    it { is_expected.to validate_presence_of(:p2_score) }
  end
end
