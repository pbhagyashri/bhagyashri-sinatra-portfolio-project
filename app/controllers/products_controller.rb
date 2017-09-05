class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/products'
  end

  get '/products/new' do
    @user = Helpers.current_user(session)
    @companies = @user.companies
    erb :'/products/new'
  end

  post '/products' do
    @user = User.find_by(id: session[:id])

    #checking user's products to see if product that user is trying to create already exists.
    @product = @user.products.find_by(name: params[:user][:product][:name])
    if @product.nil?
      # if product doesn't already exists, creates a new products
      @product = Product.create(params[:user][:product])
      if params[:user][:company_name].empty?
        @company = @user.companies.find_by(id: params[:user][:product][:company_id])
        @company.products << @product
      else
        @company = @user.companies.find_or_create_by(name: params[:user][:company_name])
        @company.products << @product
      end
        @company.save

        redirect to '/products'
      else
        #Finding user's companies to render radio buttons in new form.
        #Itterate over @companies to list out user's existing companies
        @companies = @user.companies
         flash[:message] = "Already Exist"
         erb :'products/new'
      end
  end

  get '/products/:slug' do
    @product = Product.find_by_slug(params[:slug])
    @company = @product.company
    erb :'/products/show'
  end

  delete '/products/:slug/delete' do
    @product = Product.find_by_slug(params[:slug])
    @product.destroy
    redirect to "/products"
  end

  get '/products/:slug/edit' do
    @product = Product.find_by_slug(params[:slug])

    erb :'/products/edit'
  end

  patch '/products/:slug' do

    @product = Product.find_by_slug(params[:slug])
    @product.name = params[:user][:product][:name]
    @product.category = params[:user][:product][:category]
    @product.countries_of_use = params[:user][:product][:countries_of_use]
    @product.active_ingredients = params[:user][:product][:active_ingredients]
    @product.product_application = params[:user][:product][:product_application]

    if !params[:user][:company_name].empty?
      @user = User.find(session[:id])

      company = Company.create(name: params[:user][:company_name])
      @product.company = company
      @user.companies << company

    else
      @product.company = Company.find_by(id: params[:user][:product][:company_id])
    end

    @product.save
    redirect to "/products/#{@product.slug}"
  end

end
