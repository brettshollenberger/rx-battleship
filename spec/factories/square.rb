FactoryGirl.define do
  factory :square do
    x "A"
    y 1
    association :board, :factory => :board
  end
end
