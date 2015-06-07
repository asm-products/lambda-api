require 'rails_helper'

describe Answer, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:question).inverse_of(:answers) }

    it do
      is_expected.to have_many(:responses).inverse_of(:answer).dependent(:destroy)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:question) }
    it { is_expected.to validate_presence_of(:content) }
  end
end
