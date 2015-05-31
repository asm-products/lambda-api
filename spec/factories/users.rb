FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    biography { Faker::Lorem.sentence }
    sequence(:email) { |n| Faker::Internet.email("#{first_name}-#{last_name}-#{n}") }
    password 'password'

    factory :google_user do
      provider 'google_oauth2'
      uid SecureRandom.uuid
    end

    factory :facebook_user do
      provider 'facebook_access_token'
      uid SecureRandom.uuid
    end
  end
end
