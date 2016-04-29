# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.admin.where(email: "admin@forthventures.com").first
unless u
  User.admin.create!(email: "admin@forthventures.com", password: "12345678", password_confirmation: "12345678")
end