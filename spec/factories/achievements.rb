FactoryGirl.define do
  factory :achievement do
    sequence(:title) { |n| "Achievement#{n}" }
    description "description"
    privacy Achievement.privacies[:privacy_access]
    featured false
    cover_image "some_file.png"

    factory :public_achievement do
      privacy Achievement.privacies[:privacy_access]
    end
  end
end
