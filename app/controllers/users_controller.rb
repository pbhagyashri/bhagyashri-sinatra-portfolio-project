class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/'
    end
  end

  post '/signup' do
    existing_user = User.find_by(username: params[:user][:username], email: params[:user][:email])
    if !existing_user
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect '/companies'
      else
        erb :'users/create_user'
      end
    else
      flash[:message] = "Username and email already exists"
      erb :'users/create_user'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do

    @user = User.find_by(username: params[:user][:username], email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect to '/companies'
    #else
      #flash[:message] = "Please enter valid email, username and password"
    end

  end

  get '/companies' do
    erb :'/companies/companies'
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end
