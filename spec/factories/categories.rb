FactoryGirl.define do
  factory :category do
    name { "#{Faker::Hacker.adjective} #{Faker::Hacker.noun}" }

    trait :with_games do
      after(:build, :stub) do |category|
        create_list :game, 3, category: category
      end
    end

    trait :with_gems do
      after(:build, :stub) do |category|
        create_list :category_gem, 3, category: category
      end
    end

    trait :with_questions do
      after(:build, :stub) do |category|
        create_list :question, 3, category: category
      end
    end

    trait :with_children do
      after(:build, :stub) do |category|
        create_list :category, 3, parent: category
      end
    end

    trait :with_parent do
      parent { create :category }
    end

    trait :with_all do
      with_gems
      with_games
      with_questions
      with_children
      with_parent
    end
  end
end
