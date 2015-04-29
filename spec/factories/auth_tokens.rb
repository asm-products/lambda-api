FactoryGirl.define do
  factory :auth_token do
    user

    trait :mock_relations do
      user { build_stubbed :user }
    end
  end
end
