# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# メインのサンプルユーザー1人
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  name = Faker::Lorem.sentence(word_count: 1)
  goods_condition = Faker::Lorem.sentence(word_count: 1)
  delivery_condition = Faker::Lorem.sentence(word_count: 1)
  area = Faker::Lorem.sentence(word_count: 1)
  description = Faker::Lorem.sentence(word_count: 5)
  price = Faker::Lorem.sentence(word_count: 1)
  size = Faker::Lorem.sentence(word_count: 1)
  users.each { |user| user.goods.create!(name: name, goods_condition: goods_condition, delivery_condition: delivery_condition, area: area, description: description, price: price, size: size) }
end
