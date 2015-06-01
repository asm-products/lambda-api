class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable,
    :confirmable, :lockable, :omniauthable,
    omniauth_providers: [:google_oauth2, :facebook_access_token,
                         :twitter_access_token]

  acts_as_paranoid

  has_many :auth_tokens, dependent: :destroy, inverse_of: :user
  has_many :category_gems, dependent: :destroy, inverse_of: :user
  has_many :responses, dependent: :nullify, inverse_of: :user
  has_many :statistics, dependent: :destroy, inverse_of: :user
  has_many :games_won, foreign_key: 'winner_id', class_name: 'Game',
    inverse_of: :winner, dependent: :nullify
  has_many :games_as_player_1, foreign_key: 'player_1_id', class_name: 'Game',
    inverse_of: :player_1, dependent: :nullify
  has_many :games_as_player_2, foreign_key: 'player_2_id', class_name: 'Game',
    inverse_of: :player_2, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true

 after_create :create_auth_token

  def games
    Game.where('player_1_id = :id or player_2_id = :id', id: id)
  end

  def self.from_omniauth(auth_hash)
    user = User.find_or_initialize_by(provider: auth_hash['provider'],
                                      uid: auth_hash['uid'])

    user.assign_attributes(email: auth_hash['info']['email'],
                           password: Devise.friendly_token,
                           first_name: auth_hash['info']['first_name'],
                           last_name: auth_hash['info']['last_name'])
    user.save
    user
  end

  private

  def create_auth_token
    auth_tokens.create
  end
end
