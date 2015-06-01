class Answer < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :question, inverse_of: :answers
  has_many :responses, inverse_of: :answer, dependent: :destroy

  validates :question, presence: true
  validates :content, presence: true
  validates :correct, inclusion: [true, false]
end
