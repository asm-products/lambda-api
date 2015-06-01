class Round < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :game, inverse_of: :rounds
  has_many :responses, inverse_of: :round, dependent: :destroy

  validates :game, presence: true
  validates :p1_score, presence: true
  validates :p2_score, presence: true
end
