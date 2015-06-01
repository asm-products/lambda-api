class Question < ActiveRecord::Base
  acts_as_paranoid

  enum difficulty: [ :beginner, :experienced ]

  belongs_to :category, inverse_of: :questions
  has_many :answers, inverse_of: :question, dependent: :destroy
  has_many :responses, inverse_of: :question, dependent: :destroy

  validates :category, presence: true
  validates :content, presence: true
  validates :difficulty, presence: true
end
