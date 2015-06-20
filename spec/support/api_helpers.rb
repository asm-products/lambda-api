# Helper to authenticate user with JWT in request specs
module ApiHelpers
  # Set a user to login as for all requests in the example
  # (only when used with the helpers below)
  # rubocop:disable Style/TrivialAccessors
  def sign_in(user)
    @_api_helpers_user = user
  end

  def sign_out
    @_api_helpers_user = nil
  end

  # Convenient helper to send send the authorization header and the format
  %i(get post put patch delete).each do |method|
    define_method("#{method}_json") do |path, params = {}, headers = {}|
      if @_api_helpers_user.present?
        headers = headers.merge 'Authorization' => "Token #{@_api_helpers_user.new_jwt}"
      end
      send method, path, params.merge(format: :json), headers
    end
  end
end

RSpec.configure do |c|
  c.include ApiHelpers, type: :request
end
