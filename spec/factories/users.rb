# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "sexycougar"
    password 'password'
    sequence(:email) {|n| "sexy.cougar#{n}@cougar.co"}
    sign_in_count 2
    about_me "I'm old and hot like Madonna"
  end
end
