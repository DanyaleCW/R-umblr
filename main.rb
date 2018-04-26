require "sinatra"
require "sinatra/activerecord"
require_relative './models/Post'
require_relative './models/User'

set :database, {adapter: 'postgresql', database: 'blog'}
#stores cookies
enable :sessions

get '/' do
    erb :index
end    

get '/signup' do
    erb :'/signup'
#if sign up successful redirect to profile page
end  

get '/login' do
    erb :'/login'
end  

post '/user/login' do
    @user = User.find_by(email: params[:email], password: params[:password]
    )
    if @user != nil
        session[:id] = @user.id
        redirect '/profile'
    else
        #user information not found, redirects to signup page
        redirect '/signup'
    end 
end  

get '/profile' do
# find users login information and redirects to profile    
    @user = User.find(session[:id])
    erb :profile
end   

get '/logout/' do
    #clears cookies
    session[:id] = nil
    redirect '/login'
end

post '/user/new' do
    #creates new user
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password],
    birthday: params[:birthday])
    #sets cookies for user and logs in
    session[:id] = @newuser.id
    redirect '/profile'
    end    

#form for editing a user 
get '/user/:id/edit' do 
    @specific_user = User.find(params[:id])
    erb :edit
end


#edit user 

put '/user/:id' do
    @specific_user = User.find(params[:id])
    @specific_user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password],
    birthday: params[:birthday])
    redirect '/profile'
    end    
  

#delete user
 delete '/user/:id' do
    User.destroy(params[:id])
    redirect to '/delete'
 end   
