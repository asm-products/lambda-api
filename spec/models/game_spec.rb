require 'rails_helper'

describe Game, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:category).inverse_of(:games) }
    it { is_expected.to belong_to(:winner).inverse_of(:games_won).class_name('User') }

    it do
      is_expected.to belong_to(:player_1).class_name('User')
        .inverse_of(:games_as_player_1)
    end

    it do
      is_expected.to belong_to(:player_2).class_name('User')
        .inverse_of(:games_as_player_2)
    end

    it { is_expected.to have_many(:rounds).inverse_of(:game).dependent(:destroy) }
    it { is_expected.to have_many(:responses).through(:rounds) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
  end
end
