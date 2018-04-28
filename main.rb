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
        redirect '/new'
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

#form for editing and deleting a user 
get '/user/:id/edit' do 
    @specific_user = User.find(params[:id])
    erb :edit
end

#edit user 
put '/user/:id' do
    @specific_user = User.find(params[:id])
    @specific_user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password],
    birthday: params[:birthday])
    session[:id] = @user.id
    end  
    
post '/user/:id' do
  redirect '/profile'
end

#delete user
delete '/user/:id' do
    User.destroy(params[:id])
    redirect '/delete'
 end   

 get '/delete' do
    erb :'/delete'
 end 


 ####POSTS
#page to display all posts
get '/post' do
    @posts = Post.all
    #session[:id] = @specific_user.id
    erb :postindex
end

#post page
get '/post/:id' do
    erb :posts
end    
#create a post form

get '/postnew' do
    erb :postnew
end

#create new post
post '/post/new' do
  #@newpost = Post.find_by(params[:id])
  @newpost = Post.create(post_name: params[:post_name], content: params[:content])
  session[:id] = @newpost.id
  redirect  '/postshow'
end

get '/postshow' do
    erb :postshow
end 

get '/post/edit/' do
    erb :postedit
end

# get '/post/:id' do
#     @specific_post = Post.find(params[:id])
#     @title = @post_name
#     erb :postedit

# end

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






