FactoryGirl.define do
  factory :ship do
    association :board, :factory => :board
  end
end
