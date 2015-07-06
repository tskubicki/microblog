require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'
require './models'


configure(:development) {set :database,"sqlite3:microblog_db.sqlite3"}
set :sessions, true
use Rack::Flash, :sweep => true

get '/' do
	#@title = "home"
	#@current_page = 'home'
	redirect "/signin"
end

get '/register' do
	@current_page = 'register'
	erb :register
end

post '/register' do
	@new_user = params[:post] #prepended hash
	#function to sanity-check input, execute add user on success
	if !User.exists?(user_name: @new_user[:user_name])
		User.create(params[:post])
		flash[:notice] = "Success! You may log in now"
		redirect "/signin"
	else
		flash[:notice] = "That user name already exists. Please try another"
		redirect "/register"
	end
	# confirmation = params[:confirm_password]
	
	# if confirmation == params[:user][:password]
		# @user = User.create(params[:user])
		# "Registered #{@user.username}"
	# else
		# "Not signed up. Check your passwords"
	# end
end

get '/signin' do
	erb :signin
end

post '/signin' do
	@signin = params[:post] #prepended hash
	@db_record = User.where(user_name: @signin[:user_name])
	#function to sanity-check input, execute add user on success
	
	#check db_record if it got anything from the User.where ...  Then, check password
	if (@db_record != []) && (@signin[:password] == @db_record.password)
		session[:user_id] = @db_record.id
		redirect "/profile/#{current_user.user_name}"
		puts "YAAAAAAA"
	else
		puts "BOOOOOO"
	end
	
end


get '/feed' do
	@title = 'feed'
	@current_page = 'feed'
	erb :feed
end

get '/profile/:user_id' do
	@current_page = 'profile'
	erb :profile
end

get '/create_tweet' do
	@current_page = 'create_tweet'
	erb :create_tweet
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end




