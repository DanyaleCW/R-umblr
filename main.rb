require "sinatra"
require "sinatra/activerecord"
require_relative './models/Post'
require_relative './models/User'

set :database, {adapter: 'postgresql', database: 'blog'}
#stores cookies
enable :sessions

get '/signup' do
    erb :'/signup' 
if sign up successful redirect to profile page
    can 

end  

get '/login' do
    erb :'/login'
end  

get '/profile' do
# find users login information and redirects to profile    
    @user = User.find(session[:id])
    erb :profile
end    


post '/user/login' do
    @user = User.find_by(email: params[:email], password: parmas[:password],
    birthday: params[:birthday])
    if @user != nil
        session[id] = @user.id
        erb :profile
    else
        #user information not found, redirects to signup page
        redirect '/signup'
    end 
end               
