FactoryBot.define do
  factory :user do
    email                 {Faker::Internet.email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    employee_number       {'1111'}
    last_name             {'山田'}
    first_name            {'太郎'}
    department            {'〇〇部'}
    role                  {'管理者'}
  end
end