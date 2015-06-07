require 'rails_helper'

describe Statistic, type: :model do
  describe 'enum' do
    it do
      is_expected.to define_enum_for(:statistic_type)
        .with([:streak, :games_played, :games_won, :correct_responses])
    end
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:user).inverse_of(:statistics) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:statistic_type) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
