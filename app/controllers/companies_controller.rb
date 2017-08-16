class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do
    @user = User.find_by(id: session[:id])

    @company = Company.find_or_create_by(name: params[:user][:company][:name])
    @user.companies << @company

    redirect to '/companies'
  end

  get '/companies/:id' do
    @company = Company.find_by(id: params[:id])
    erb :'companies/show'
  end


end
