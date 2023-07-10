FactoryBot.define do
  factory :sleep_tracking do
    association :user, factory: :user
  end
end
