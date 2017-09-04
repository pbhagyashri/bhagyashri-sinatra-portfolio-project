class CompaniesController < ApplicationController

  get '/companies' do
    erb :'companies/companies'
  end

  get '/companies/new' do
    erb :'companies/new'
  end

  post '/companies' do

    @user = User.find_by(id: session[:id])
    #checking user's companies to see if company that user is trying to create already exists.
    @company = @user.companies.find_by(name: params[:user][:company][:name], user_id: @user.id)
    if !@company.nil?
      # Rendering an error message if company already exist.
      flash[:message] = "Company Already Exists"
      redirect to 'companies/new'
    else
      #creating a new company if doesn't already exist.
      @company = Company.create(params[:user][:company])
    end
    @user.companies << @company
    @user.save
    redirect to '/companies'
  end

  get '/companies/:slug' do
    @company = Company.find_by_slug(params[:slug])
    @products = @company.products
    erb :'companies/show'
  end

  get '/companies/:slug/edit' do
    @company = Company.find_by_slug(params[:slug])
    erb :'/companies/edit'
  end

  patch '/companies/:slug' do
    @company = Company.find_by_slug(params[:slug])
    @company.name = params[:user][:company][:name]
    @company.save
    redirect to "/companies/#{@company.slug}"
  end

  delete '/companies/:slug/delete' do
    @company = Company.find_by_slug(params[:slug])
    @company.destroy
    @company.products.destroy_all
    redirect to "/companies"
  end

end
