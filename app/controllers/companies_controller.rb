class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do
    @user = User.find_by(id: session[:id])

    @company = Company.create(params[:user][:company])
    @user.companies << @company
    @user.save
    redirect to '/companies'
  end

  get '/companies/:id' do

    @company = Company.find_by(id: params[:id])
    @products = @company.products
    erb :'companies/show'
  end


end
