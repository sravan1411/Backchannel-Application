# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 User.create!(:name=>"Vishwanath",:email=>"vish@gmail.com",:password=>"infy@1234",:password_confirmation=>"infy@1234",:isAdmin=>true)
User.create!(:name=>"Ashwin",:email=>"Ashwin@gmai.com",:password=>"infy@1234",:password_confirmation=>"infy@1234",:isAdmin=>true)