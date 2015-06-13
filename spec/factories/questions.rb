FactoryGirl.define do
  factory :question do
    content { Faker::Lorem.paragraph(2) }
    difficulty 0
    category

    # must be after create because answer requires q to exist
    after(:create) do |q|
      create_list(:incorrect_answer, 3, question: q)
      create(:correct_answer, question: q)
    end

    trait :with_responses do
      after(:build, :stub) do |q|
        create_list :response, 3, question: q
      end
    end
  end
end
