module Devise
  module Models
    module JwtAuthenticatable
      extend ActiveSupport::Concern

      class_methods do
        def from_jwt(jwt)
          secret = Rails.application.secrets.secret_key_base
          claim = JSON::JWT.decode(jwt, secret)
          resource_id = claim['resource_id']
          exp = Time.at(claim['exp'])
          fail if exp < Time.now
          to_adapter.find_first(id: resource_id)
        rescue
          nil
        end
      end

      def new_jwt
        claim = build_jwt_claim
        secret = Rails.application.secrets.secret_key_base
        JSON::JWT.new(claim).sign(secret).to_s
      end

      private

      def build_jwt_claim
        {
          resource_id: id,
          exp: 1.month.from_now
        }
      end
    end
  end
end
