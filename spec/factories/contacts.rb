# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    sequence(:first_name) {|n|"Poop#{n}"}
    last_name "Dingkle"
    sequence(:email) {|n| "sexycougar#{n}@cougar.co"}
    subject "Rabble Rabble!"
    description "HEWY YOU SUCK!"
  end
end
