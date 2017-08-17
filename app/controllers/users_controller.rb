class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.create(params[:user])
    session[:id] = @user.id
    redirect '/companies'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do

    @user = User.find_by(username: params[:user][:username], email: params[:user][:email])
    if @user
      session[:id] = @user.id
      session[:username] = @user.username
      session[:email] = @user.email
      session[:password] = @user.password
      redirect to '/companies'
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
