class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do
    @company = Company.create(params[:company])

    redirect to '/companies'
  end
end
