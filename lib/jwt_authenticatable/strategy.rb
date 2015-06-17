require 'devise/strategies/base'

module JwtAuthenticatable
  class Strategy < Devise::Strategies::Authenticatable
    def valid?
      auth_jwt.present?
    end

    def authenticate!
      user = mapping.to.from_jwt(auth_jwt)
      success! user if user.present?
    end

    def store?
      false
    end

    private

    def auth_jwt
      ActionController::HttpAuthentication::Token.token_and_options(request).try :[], 0
    end
  end
end
