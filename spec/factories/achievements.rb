FactoryGirl.define do
  factory :achievement do
    sequence(:title) { |n| "Achievement#{n}" }
    description "description"
    featured false
    cover_image "some_file.png"

    factory :privacy_achievement do
      privacy :privacy_access
    end

    factory :public_achievement do
      privacy :public_access
    end
  end
end
