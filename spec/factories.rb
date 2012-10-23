FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :note do
    code "Lorem ipsum"
    description "Ipsum lorem"
    user

    factory :nonpublic do
      nonpublic true
    end
  end

  factory :comment do
    comment "Commentimus Maximus"
  end
end
