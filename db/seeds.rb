# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Test Admin', :email => 'admin@example.com', :password => 'password', :password_confirmation => 'password'
puts 'New user created: ' << user.name
user.add_role :admin

user = User.create! :name => 'Test Dispatcher', :email => 'dispatcher@example.com', :password => 'password', :password_confirmation => 'password'
puts 'New user created: ' << user.name
user.add_role :dispatcher
user.add_role :courier

user = User.create! :name => 'Test Courier', :email => 'courier@example.com', :password => 'password', :password_confirmation => 'password'
puts 'New user created: ' << user.name
user.add_role :courier

user = User.create! :name => 'Test Client', :email => 'client@example.com', :password => 'password', :password_confirmation => 'password'
puts 'New user created: ' << user.name
user.add_role :client
