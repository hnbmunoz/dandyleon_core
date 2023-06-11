# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#AdminAcct
User.new(
  "fname": "Henri Nicholli",
  "mname": "B",
  "lname": "Munoz",
  "email": "hnbmunoz@gmail.com",
  "display_name": "Henri",
  # "activation_token": generate_token
).save


Account.new(
  "user_id": 1,
  "username": "hnbmunoz",
  "password": "g3tP4$$W0rd",
  "user_level": 1,
).save
#AdminAcct

#Sample Category
Category.new("name": "earrings", "description": "default earrings", "url": "").save
Category.new("name": "necklace", "description": "default necklace", "url": "").save

#AdminAcct