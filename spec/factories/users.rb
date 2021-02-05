FactoryBot.define do
  factory :user do
    Faker::Config.locale = :ja
    nickname               { Faker::Name.initials(number: 2) }
    email                  { Faker::Internet.free_email }
    password               { '123abc' }
    password_confirmation  { password }
    last_name              { Faker::Name.last_name }
    first_name             { Faker::Name.first_name }
    last_name_kana         { 'アイウ' }
    first_name_kana        { 'ウエオ' }
    birthday               { '1995-10-11' }
  end
end
