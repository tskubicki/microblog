require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'


configure(:development) {set :database,"sqlite3:microblog_db.sqlite3"}
set :sessions, true

get '/' do
	@title = "home"
	@current_page = 'home'
	erb :home
end

get '/register' do
	@current_page = 'register'
	erb :register
end

post '/register' do
	confirmation = params[:confirm_password]
	
	if confirmation == params[:user][:password]
		@user = User.create(params[:user])
		"Registered #{@user.username}"
	else
		"Not signed up. Check your passwords"
	end
end


get '/feed' do
	"Hello world"
	@title = 'feed'
	@current_page = 'feed'
	erb :feed
end

get '/profile' do
	@current_page = 'profile'
	erb :profile
end

get '/create_tweet' do
	@current_page = 'create_tweet'
	erb :create_tweet
end




