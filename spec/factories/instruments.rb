FactoryBot.define do
  factory :instrument do
    name              {'計測器名'}
    management_number {'管理番号'}
    manufacturer      {'メーカー'}
    model             {'型式'}
    serial_number     {'製造番号'}
    last_inspected_at { Time.now }

    association :admin, factory: :user
    association :inspector, factory: :user
  end
end
