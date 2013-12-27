# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prose do
    user_id 1
    title "Best Story Ever"
    description "it was a dark and stormy night and nothing happened the end."
    current_state 1
  end
end
