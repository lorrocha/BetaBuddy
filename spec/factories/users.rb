# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "sexycougar"
    encrypted_password "ermagerrrd"
    email "sexy.cougar@cougar.co"
    last_login "2013-12-27"
    about_me "I'm old and hot like Madonna"
  end
end
