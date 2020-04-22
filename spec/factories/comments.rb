FactoryBot.define do
  factory :comment do
    body { "MyString" }
    association :user, factory: :user
    association :article, factory: :article
  end
end
