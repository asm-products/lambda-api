class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable,
    :confirmable, :lockable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
