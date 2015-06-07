class Statistic < ActiveRecord::Base
  acts_as_paranoid

  enum statistic_type: [:streak, :games_played, :games_won, :correct_responses]

  belongs_to :user, inverse_of: :statistics

  validates :statistic_type, presence: true
  validates :value, presence: true
  validates :user, presence: true
end
