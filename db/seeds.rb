# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
Event.create(
    positionID: 1,
    creatorID: 1,
    description: "hej"
)
Tag.create(tag: "taggg")

Position.create(
    lat: 1.32423,
    long: 1.43533
)
Creator.create(
    creator: "Chimmichanga"
)

User.create!(username:              "Erik",
             email:                 "Erik@gmaill.org",
             password:              "password",
             password_confirmation: "password",
             key:                   "admin",
             admin: true)


10.times do |n|
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
