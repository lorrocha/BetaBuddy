# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prose_tag do
    prose
    genre
  end
end
