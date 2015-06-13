FactoryGirl.define do
  factory :response do
    question
    round
    user

    trait :with_answer do
      answer
    end
  end
end
