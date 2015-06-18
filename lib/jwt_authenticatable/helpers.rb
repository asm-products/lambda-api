module JwtAuthenticatable
  module Helpers
    extend ActiveSupport::Concern

    included do
      after_action :set_new_jwt
    end

    def set_new_jwt
      Devise.mappings.each do |name, m|
        next unless m.modules.include? :jwt_authenticatable

        resource = send "current_#{name}"
        signed_in = send "#{name}_signed_in?"
        header_key = "X-#{name.to_s.capitalize}-JWT"
        response.headers[header_key] = resource.new_jwt if signed_in
      end
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  include JwtAuthenticatable::Helpers
end
