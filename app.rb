require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require './models'


configure(:development) {set :database,"sqlite3:microblog_db.sqlite3"}
set :sessions, true
use Rack::Flash, :sweep => true

get '/' do
	#@title = "home"
	#@current_page = 'home'
	erb :home
end

get '/register' do
	@current_page = 'register'
	erb :register
end

post '/register' do
	@new_user = params[:post] #prepended hash
	#function to sanity-check input, execute add user on success
	if (@new_user[:password] == params[:confirm_password])
		if !User.exists?(user_name: @new_user[:user_name])
			User.create(params[:post])
			flash[:notice] = "Success! You may log in now"
			redirect "/"
		else
			flash[:notice] = "That user name already exists. Please try another"
			redirect "/"
		end
	else
		flash[:notice] = "Passwords did not match. Please try again."
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

post '/signin' do
	@signin = params[:post] #prepended hash
	@db_record = User.find_by(user_name: @signin[:user_name])
	#function to sanity-check input, execute add user on success
	
	# check db_record if it got anything from the User.where ...  Then, check password
	if (@db_record != nil) && (@signin[:password] == @db_record.password)
		session[:user_id] = @db_record.id
		redirect "/profile/#{current_user.user_name}"
	else
		flash[:notice] = "Incorrect login. Please try again."
		redirect "/"
	end
	
end

get '/feed' do
	# @title = 'feed'
	# @current_page = 'feed'
	@posts = Post.order('created_at DESC').limit(10)
	erb :feed
end

get '/profile/:user_id' do 
	@current_user = User.find_by(user_name: current_user.user_name)
	@posts = @current_user.posts
	#@current_page = 'profile'
	erb :profile
end

get '/create_tweet' do
	@current_page = 'create_tweet'
	erb :create_tweet
end

get '/signout' do
	session[:user_id] = nil
	flash[:notice] = "You have been signed out. Come back soon!"
	redirect "/"
end

get '/profile/:user_id/edit' do
	erb :edit
end

post '/profile/:user_id/delete' do
	User.destroy(current_user)
	session[:user_id] = nil
	flash[:notice] = "Account deleted"
	redirect "/"
end

post '/profile/:user_id/edit' do
	current_user.update(params[:post])
	flash[:notice] = "You changes were saved"
	redirect "/profile/#{current_user.user_name}"
end

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end

post '/newpost' do
	Post.create(user_id: current_user.id, 
		content: params[:message])
	flash[:notice] = "You just created a post"
	redirect "/profile/#{current_user.user_name}"
end



