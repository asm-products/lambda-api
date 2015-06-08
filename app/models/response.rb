class Response < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :answer, inverse_of: :responses
  belongs_to :question, inverse_of: :responses
  belongs_to :round, inverse_of: :responses
  belongs_to :user, inverse_of: :responses

  validates :question, presence: true
  validates :round, presence: true
  validates :user, presence: true
end
