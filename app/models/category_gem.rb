class CategoryGem < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :category, inverse_of: :category_gems
  belongs_to :user, inverse_of: :category_gems

  validates :category, presence: true
  validates :user, presence: true
  validates :count, presence: true
end
