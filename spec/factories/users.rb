FactoryGirl.define do
  factory :user, aliases: [:player_1, :player_2, :winner] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    biography { Faker::Lorem.sentence }
    sequence(:email) { |n| Faker::Internet.email("#{first_name}-#{last_name}-#{n}") }
    password 'password'

    factory :google_oauth2_user do
      provider 'google_oauth2'
      uid SecureRandom.uuid
    end

    factory :facebook_access_token_user do
      provider 'facebook_access_token'
      uid SecureRandom.uuid
    end

    trait :with_category_gems do
      after(:build, :stub) do |user|
        create_list :category_gem, 3, user: user
      end
    end

    trait :with_responses do
      after(:build, :stub) do |user|
        create_list :response, 3, user: user
      end
    end

    trait :with_statistics do
      after(:build, :stub) do |user|
        create_list :statistic, 3, user: user
      end
    end

    trait :with_games do
      after(:build, :stub) do |user|
        create_list :game, 2, player_1: user
        create_list :game, 2, player_2: user
      end
    end

    trait :with_games_won do
      after(:build, :stub) do |user|
        create_list :game, 3, winner: user
      end
    end

    trait :with_all do
      with_category_gems
      with_responses
      with_statistics
      with_games
      with_games_won
    end
  end
end
