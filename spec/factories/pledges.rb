FactoryGirl.define do
  factory :pledge do
    association :user, factory: :user
    association :campaign, factory: :campaign
    amount { 1 + rand(100)}
  end
end
