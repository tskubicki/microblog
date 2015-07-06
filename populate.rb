require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'

#Used to populate some basic information into the DB for testing purposes
#delete your db and run "bundle exec rake db:migrate" before using

configure(:development) {set :database,"sqlite3:microblog_db.sqlite3"}

User.create(:user_name => "tom", :password => "tom", :first_name => "Thomas", :last_name => "Smith", :email => "tom@tom.com", :created_at => DateTime.now, :updated_at => DateTime.now)
User.create(:user_name => "bob", :password => "bob", :first_name => "Thomas", :last_name => "Smith", :email => "bob@bob.com", :created_at => DateTime.now, :updated_at => DateTime.now)
User.create(:user_name => "joe", :password => "joe", :first_name => "Thomas", :last_name => "Smith", :email => "joe@joe.com", :created_at => DateTime.now, :updated_at => DateTime.now)

Group.create(:group_name => "cool people", :about => "a group for cool people", :created_at => DateTime.now, :updated_at => DateTime.now)
Group.create(:group_name => "geeky people", :about => "a group for geeky people", :created_at => DateTime.now, :updated_at => DateTime.now)

Post.create(:user_id => 1, :content => "Lol", :created_at => DateTime.now, :updated_at => DateTime.now)
Post.create(:user_id => 2, :content => "lul", :created_at => DateTime.now, :updated_at => DateTime.now)
Post.create(:user_id => 2, :content => "rofl", :created_at => DateTime.now, :updated_at => DateTime.now)
Post.create(:user_id => 3, :content => "wut", :created_at => DateTime.now, :updated_at => DateTime.now)
Post.create(:user_id => 4, :content => "lmao", :created_at => DateTime.now, :updated_at => DateTime.now)

testuser1 = User.find(1)
testuser2 = User.find(2)
testuser2 = User.find(3)

#groups
testgroup1 = Group.find(1)
testgroup2 = Group.find(2)
testgroup1.users.all

# get all posts in a group 
testgroup1.users << testuser1
testgroup1.posts 

#follow a user
user1.followers << user2

#get users followers
user1.followers