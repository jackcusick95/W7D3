FactoryBot.define do
    factory :user do
        username { |n| Faker::Internet.username}
        password { |p| Faker::Internet.password}

    end

end