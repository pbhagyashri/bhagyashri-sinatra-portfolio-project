class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do
    binding.pry
    @company = Company.create(params[:company])
    redirect to '/companies'
  end

  get '/companies/:id' do
    @company = Company.find_by(id: params[:id])
    erb :'companies/show'
  end


end
