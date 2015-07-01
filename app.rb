require 'sinatra'
require 'sinatra/activerecord'
require './models.rb'

set :database,"sqlite3:microblog_db.sqlite3"

get '/sign-up' do
	erb :sign_up
end

post '/sign-up' do
	confirmation = params[:confirm_password]
	
	if confirmation == params[:user][:password]
		@user = User.create(params[:user])
		"Signed up #{@user.username}"
	else
		"Not signed up. Check your passwords"
	end

end

