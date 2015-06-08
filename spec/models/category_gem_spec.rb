require 'rails_helper'

describe CategoryGem, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:category).inverse_of(:category_gems) }
    it { is_expected.to belong_to(:user).inverse_of(:category_gems) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:count) }
  end
end
