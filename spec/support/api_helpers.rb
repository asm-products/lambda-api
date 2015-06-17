# Helper to authenticate user with JWT in request specs
module ApiHelpers
  %i(get post put patch delete).each do |method|
    define_method("#{method}_json") do |path, params = {}, headers = {}|
      send method, path, params.merge(format: :json), headers
    end
  end
end

RSpec.configure do |c|
  c.include ApiHelpers, type: :request
end
