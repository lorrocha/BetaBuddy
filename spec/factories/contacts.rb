# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    first_name "Poop"
    last_name "Dingkle"
    email "something@something.com"
    subject "Rabble Rabble!"
    description "HEWY YOU SUCK!"
  end
end
