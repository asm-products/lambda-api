FactoryGirl.define do
  factory :round do
    game
    p1_score { rand 10 }
    p2_score { rand 10 }

    trait :with_responses do
      after(:build, :stub) do |round|
        create_list :response, 3, round: round
      end
    end
  end
end
