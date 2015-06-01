FactoryGirl.define do
  factory :statistic, aliases: [:streak_statistic] do
    statistic_type 0
    value { rand 100 }
    user
  end
end
