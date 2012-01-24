# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    latitude 0.0
    longitude 0.0
    speed 0.0
    compass 0
    distance 0
    time 0
    association :log
  end
end
