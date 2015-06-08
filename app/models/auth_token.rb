class AuthToken < ActiveRecord::Base
  belongs_to :user, inverse_of: :auth_tokens

  validates :user, presence: true

  before_create :set_token
  after_create :set_expires_at

  private

  def set_token
    loop do
      self.token = SecureRandom.uuid
      break unless self.class.exists?(token: token)
    end
  end

  def set_expires_at
    self.expires_at = created_at + 2.weeks
  end
end
