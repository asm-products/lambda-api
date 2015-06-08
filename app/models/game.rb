class Game < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :category, inverse_of: :games
  belongs_to :player_1, class_name: 'User', inverse_of: :games_as_player_1
  belongs_to :player_2, class_name: 'User', inverse_of: :games_as_player_2
  belongs_to :winner, class_name: 'User', inverse_of: :games_won
  has_many :rounds, inverse_of: :game, dependent: :destroy
  has_many :responses, through: :rounds

  validates :category, presence: true
end
