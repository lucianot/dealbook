require 'json'

# set users
puts 'SETTING UP DEFAULT USER LOGIN'
admin = User.create! :full_name => 'The Admin',
                     :email => 'admin@example.com',
                     :password => 'please',
                     :password_confirmation => 'please'
admin.role = 'admin'
admin.save!
puts 'New user created: ' << admin.full_name

mod = User.create!  :full_name => 'The Moderator',
                    :email => 'mod@example.com',
                    :password => 'please',
                    :password_confirmation => 'please'
mod.role = 'moderator'
mod.save!
puts 'New user created: ' << mod.full_name

user = User.create! :full_name => 'Normal User',
                    :email => 'normal@example.com',
                    :password => 'please',
                    :password_confirmation => 'please'
user.role = 'normal'
user.save!
puts 'New user created: ' << user.full_name

# parse json
filename = "#{Rails.root}/db/brazil_locations.json"
data = File.read(filename)
parsed_data = JSON.parse(data)

# store in hash
states = {}
parsed_data['estados'].each do |state|
  states[state['sigla']] = state['cidades']
end

# populate DB
# puts 'POPULATING LOCATIONS FOR BRAZIL'
# states.each do |state, cities|
#   cities.each do |city|
#     Location.create!(country: "Brazil",
#                      region: state,
#                      city: city)
#   end
# end
# puts 'Locations populated!'


