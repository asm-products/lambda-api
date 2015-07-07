source 'https://rubygems.org'

# Project-specific
gem 'devise', '~> 3.4.1'
gem 'paranoia', '~> 2.1.2'
gem 'high_voltage', '~> 2.3.0'
gem 'foundation-rails', '~> 5.5.2.1'
gem 'font-awesome-sass', '~> 4.3.0'
gem 'omniauth-google-oauth2', github: 'zquestz/omniauth-google-oauth2'
gem 'omniauth-facebook-access-token', '~> 0.1.7'
gem 'omniauth-twitter-access-token', '~> 0.0.2'
gem 'figaro'
gem 'quiet_assets'
gem 'pundit', '1.0.1'
gem 'json-jwt', '~> 1.0.0'
gem 'email_validator', '~> 1.6.0'
gem 'mailchimp-api', '~> 2.0.6'

# Rails 4.2 Defaults
gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

group :integration, :development, :test do
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'letter_opener', '~> 1.3.0'
end

group :development, :test do
  gem 'rubocop', require: false
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'rspec-its', '~> 1.2.0'
  gem 'json-schema', '~> 2.5.1'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'faker', '~> 1.4.3'
  gem 'coveralls', require: false
  gem 'timecop'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
end
