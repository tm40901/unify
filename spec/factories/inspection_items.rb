FactoryBot.define do
  factory :inspection_item do
    item {'点検項目'}

    association :instrument
  end
end
