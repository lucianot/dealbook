# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :full_name => 'The Admin', 
                    :email => 'admin@example.com', 
                    :password => 'please', 
                    :password_confirmation => 'please'
puts 'New user created: ' << user.full_name

user2 = User.create! :full_name => 'Normal User', 
                     :email => 'normal@example.com', 
                     :password => 'please', 
                     :password_confirmation => 'please'
puts 'New user created: ' << user2.full_name

user.add_role :admin