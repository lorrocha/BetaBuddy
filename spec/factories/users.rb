# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "sexycougar#{n}"}
    password 'password'
    sequence(:email) {|n| "sexy.cougar#{n}@cougar.co"}
    sign_in_count 2
    about_me "I'm old and hot like Madonna"
    role "member"
  end
end
