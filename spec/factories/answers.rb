FactoryGirl.define do
  factory :answer, aliases: [:incorrect_answer] do
    content { Faker::Lorem.paragraph 1 }
    correct false
    question

    factory :correct_answer do
      correct true
    end
  end
end
