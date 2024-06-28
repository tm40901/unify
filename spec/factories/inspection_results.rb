FactoryBot.define do
  factory :inspection_result do
    result    {'Pass'}
    custom_id {'00000000000000000'}
    status    {'Pending'}

    association :instrument
    association :inspection_item
    association :inspector, factory: :user
    association :approver, factory: :user
  end
end
