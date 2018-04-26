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

get '/profile' do
# find users login information and redirects to profile    
    @user = User.find(session[:id])
    erb :profile
end   

get '/logout' do
    #clears cookies
    session[:id] = nil
    redirect '/login'
end

get '/profile' do 
    erb :profile
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

post '/user/new' do
    #creates new user
    @newuser = User.create(email: params[:email], password: params[:password],
    birthday: params[:birthday])
    #sets cookies for user and logs in
    session[:id] = @newuser.id
    redirect '/profile'
    end    

private 
#Potentially useful function instead of checking if the user exists
def user_exists?
    (session[:id] != nil) ? true : false
end

def current_user
    User.find(session[:id])
end    
