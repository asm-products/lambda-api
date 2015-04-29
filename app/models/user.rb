class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable,
    :confirmable, :lockable

  has_many :auth_tokens

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :create_auth_token

  private

  def create_auth_token
    auth_tokens.create
  end
end
