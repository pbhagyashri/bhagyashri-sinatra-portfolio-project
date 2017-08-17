class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do
    @user = User.find_by(id: session[:id])

    @company = Company.find_or_create_by(params[:user][:company])
    @user.companies << @company
    @user.save
    redirect to '/companies'
  end

  get '/companies/:slug' do
    @company = Company.find_by_slug(params[:slug])
    @products = @company.products
    erb :'companies/show'
  end


end
