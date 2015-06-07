require 'rails_helper'

describe Category, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:parent).inverse_of(:children) }

    it do
      is_expected.to have_many(:games).inverse_of(:category).dependent(:destroy)
    end

    it do
      is_expected.to have_many(:category_gems).inverse_of(:category)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:questions).inverse_of(:category)
        .dependent(:destroy)
    end

    it do
      is_expected.to have_many(:children).with_foreign_key('parent_id')
        .class_name(:'Category').inverse_of(:parent).dependent(:destroy)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
