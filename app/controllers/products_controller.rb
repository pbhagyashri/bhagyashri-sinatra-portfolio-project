class ProductsController < ApplicationController

  get '/products' do
    if is_logged_in?
      erb :'/products/products'
    else
      redirect to '/login'
    end
  end

  get '/products/new' do
    if is_logged_in?
      @companies = current_user.companies
      erb :'/products/new'
    else
      redirect to '/login'
    end
  end

  post '/products' do
    if is_logged_in?

      #checking user's products to see if product that user is trying to create already exists.
      if current_user.products.find_by(name: params[:product][:name])
        flash[:message] = "Product Already Exists"
        redirect to 'products/new'
      else
        # if product doesn't already exists, creates a new products
        @product = current_user.products.build(params[:product])
        #Finding user's companies to render radio buttons in new form.
        @companies = current_user.companies

        if params[:company][:company_name].empty?
          @company = current_user.companies.find_by(id: params[:product][:company_id])
          @company.products << @product
        else
          @company = current_user.companies.find_or_create_by(name: params[:company][:company_name])
          @company.products << @product
        end

        if @product.save
          redirect to '/products'
        else
          flash[:message] = @product.errors
          redirect to 'product/new'
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/products/:slug' do

    if is_logged_in?
      @product = current_user.products.find_by_slug(params[:slug])
      @company = @product.company
      erb :'/products/show'
    else
      redirect to '/login'
    end

  end

  delete '/products/:slug/delete' do
    if is_logged_in?
      @product = current_user.products.find_by_slug(params[:slug])
      @product.destroy
      redirect to "/products"
    else
      redirect to '/login'
    end
  end

  get '/products/:slug/edit' do

    @product = current_user.products.find_by_slug(params[:slug])
    erb :'/products/edit'

  end

  patch '/products/:slug' do

    if is_logged_in?
      @product = current_user.products.find_by_slug(params[:slug])
      @product.name = params[:product][:name]
      @product.category = params[:product][:category]
      @product.countries_of_use = params[:product][:countries_of_use]
      @product.active_ingredients = params[:product][:active_ingredients]
      @product.product_application = params[:product][:product_application]

      if !params[:company][:company_name].empty?
        company = Company.create(name: params[:company][:company_name])
        @product.company = company
        current_user.companies << company
      else
        @product.company = current_user.companies.find_by(id: params[:product][:company_id])
      end

      @product.save
      redirect to "/products/#{@product.slug}"

    else
      redirect to '/login'
    end
  end


end
