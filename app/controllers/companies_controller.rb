class CompaniesController < ApplicationController

  get '/companies' do
    if is_logged_in?
      @companies = current_user.companies
      erb :'companies/companies'
    else
      redirect to '/login'
    end
  end

  get '/companies/new' do
    if is_logged_in?
      erb :'companies/new'
    else
      redirect to '/login'
    end
  end

  post '/companies' do

    if is_logged_in?
      #checking user's companies to see if company that user is trying to create already exists.
      if current_user.companies.find_by(name: params[:company][:name])
        # Rendering an error message if company already exist.
        flash[:message] = "Company Already Exists"
        redirect to 'companies/new'
      else
        #creating a new company if doesn't already exist.
        @company = current_user.companies.build(params[:company])
        if @company.save
          redirect to '/companies'
        else
          flash[:message] = @company.errors
          redirect to 'companies/new'
        end
      end #current_user.companies.find_by
    else
      redirect to '/login'
    end #logged_in?

  end #post '/companies'

  get '/companies/:slug' do
    if is_logged_in?
      @company = current_user.companies.find_by_slug(params[:slug])
      @products = @company.products
      erb :'companies/show'
    else
      redirect to '/login'
    end
  end

  get '/companies/:slug/edit' do
    if is_logged_in?
      @company = current_user.companies.find_by_slug(params[:slug])
      erb :'/companies/edit'
    else
      redirect to '/login'
    end
  end

  patch '/companies/:slug' do
    if is_logged_in? && current_user
      @company = current_user.companies.find_by_slug(params[:slug])
      @company.name = params[:company][:name]
      @company.save
      redirect to "/companies/#{@company.slug}"
    else
      redirect to '/login'
    end
  end

  delete '/companies/:slug/delete' do
    if is_logged_in? && current_user
      @company = Company.find_by_slug(params[:slug])
      @company.destroy
      @company.products.destroy_all
      redirect to "/companies"
    else
      redirect to '/login'
    end
  end

end
