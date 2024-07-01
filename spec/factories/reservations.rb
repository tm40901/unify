FactoryBot.define do
  factory :reservation do
    start_time    { Time.now }
    end_time      { 1.hour.from_now }

    association :instrument
    association :user
  end
end
