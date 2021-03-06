# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Event.create(
    position_id: 1,
    creator_id: 1,
    tag_id: 1,
    description: "hej"
)
Tag.create(tag: "taggg")

Position.create(
    lat: 40.1,
    long: 50.2
)
=begin
Creator.create(
    creator: "Chimmichanga",
    password: "password"
)
=end
1.times do |n|
  name  = "testare"
  password = "password"
  Creator.create!(creator:               name,
                  password:              password,
                  password_confirmation: password
  )
end

User.create!(username:              "Erik",
             email:                 "Erik@gmail.org",
             password:              "password",
             password_confirmation: "password",
             key:                   "admin",
             admin: true)


2.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(username:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               key:SecureRandom.hex(20)
  )
end