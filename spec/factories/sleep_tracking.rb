FactoryBot.define do
  factory :sleep_tracking do
    sleep_time { DateTime.now - 8.hours }
    wake_up_time { DateTime.now }
    association :user, factory: :user
  end
end
