FactoryGirl.define do
  factory :game do
    category
  end

  trait :with_players do
    player_1
    player_2
  end

  trait :with_winner do
    with_players
    winner { player_1 }
  end

  trait :with_rounds do
    after(:build, :stub) do |game|
      create_list :round, 3, game: game
    end
  end

  trait :with_responses do
    after(:build, :stub) do |game|
      create_list :round, 3, :with_responses, game: game
    end
  end

  trait :with_all do
    with_winner
    with_rounds
    with_responses
  end
end
