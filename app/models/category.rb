class Category < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :parent, class_name: 'Category', inverse_of: :children
  has_many :games, inverse_of: :category, dependent: :destroy
  has_many :category_gems, inverse_of: :category, dependent: :destroy
  has_many :questions, inverse_of: :category, dependent: :destroy
  has_many :children, class_name: 'Category', foreign_key: 'parent_id',
    inverse_of: :parent, dependent: :destroy

  validates :name, presence: true
end
