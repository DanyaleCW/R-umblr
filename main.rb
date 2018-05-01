require "sinatra"
require "sinatra/activerecord"
require_relative './models/Post'
require_relative './models/User'

set :database, {adapter: 'postgresql', database: 'blog'} #makes sure to comment out when pushing to heroku
#stores cookies
enable :sessions

get '/' do
    erb :main
end    

get '/signup' do
    erb :new
#if sign up successful redirect to profile page
end  

get '/login' do
    erb :login
end  

post '/user/login' do
    @user = User.find_by(email: params[:email], password: params[:password]
    )
    if @user != nil
        session[:id] = @user.id
        redirect '/profile'
    else
        #user information not found, redirects to signup page
        redirect '/new'
    end 
end  

get '/new' do
    erb :new
end

get '/profile' do
#find users login information and redirects to profile    
    @user = User.find(session[:id])
    @posts = Post.where(user_id: @user.id).limit(20)
    erb :profile
end 

get '/logout/' do
    #clears cookies
    session[:id] = nil
    redirect '/login'
end

post '/user/new' do
    #creates new user
    @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password],
    birthday: params[:birthday])
    #sets cookies for user and logs in
    session[:id] = @user.id
    redirect '/profile'
    end    

#READ an existing instance of User
#get /users/1  means get the users show page for User with an ID of 1
get '/users/:id' do
  #ruby sees params{id=value}
  # /users/1
  #ruby sees params{id: 1}
  @user = User.find(params[:id]) #define instance variable for view
  erb :show #show single user view
end

#form for editing and deleting a user 
get '/user/:id/edit' do 
    @user = User.find(params[:id])
    erb :edit
end

#edit user 
put '/user/:id' do
    @user = User.find(params[:id])
    @user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password],
    birthday: params[:birthday])
    session[:id] = @user.id
    end  
    
post '/user/:id' do
  redirect '/profile'
end

#delete user should destroy posts as well as user
delete '/user/:id' do
    @user = User.find(session[:id])
    User.destroy(params[:id])
    redirect '/delete'
 end   

 get '/delete' do
    erb :'/delete'
 end 


 ####POSTS   
#create a post form
get '/postnew/:id' do
    @user = User.find(session[:id])
    erb :postnew
end

#create new post
post '/postnew/:id' do
  @user = User.find(session[:id])
  @posts = Post.create(post_name: params[:post_name], content: params[:content], user_id: @user.id)
  redirect  '/profile'
end

#gets other peoples blog posts need to make a route in the profile link <%%> that goes to each of the routes for the individual users

get '/posts/:username' do
    @user = User.where(params[:first_name])
    @posts = @user.posts
    erb :postshow
end

#below I am working the user having the ability to edit and delete a post

#form for editing and deleting blog posts
# get '/post/:id/edit' do
#   @specific_post = Post.find(params[:id])
#   @title = "Edit Form"
#   erb :postedit
# end

# #edit posts
# put '/post/:id' do
#     @specific_post = Post.find_by_id(params[:id])
#     @specific_post.update(post_name: params[:post_name], content: params[:content])
#     session[:id]= @user.id
#     #redirect '/postshow' #does not edit
# end 

# post 'post/:id' do
#   redirect '/profile'
# end

#  #delete post
# delete '/post/:id' do
#   Post.destroy(params[:id])
#   redirect to '/postdelete'
# end

# get '/delete' do
#     erb :'/postdelete'
#  end 






