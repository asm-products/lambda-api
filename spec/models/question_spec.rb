require 'rails_helper'

describe Question, type: :model do
  describe 'enum' do
    it { is_expected.to define_enum_for(:difficulty)
         .with([:beginner, :experienced]) }
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:category).inverse_of(:questions) }

    it { is_expected.to have_many(:answers).inverse_of(:question)
         .dependent(:destroy) }

    it { is_expected.to have_many(:responses).inverse_of(:question)
         .dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:difficulty) }
  end
end
