FactoryGirl.define do
  factory :category_gem do
    category
    user
    count { rand 100 }
  end
end
