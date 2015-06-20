# Credit: https://robots.thoughtbot.com/validating-json-schemas-with-an-rspec-matcher
RSpec::Matchers.define :match_json_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
