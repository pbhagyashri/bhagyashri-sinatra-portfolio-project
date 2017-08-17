class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/products'
  end

  get '/products/new' do
    erb :'/products/new'
  end

  post '/products' do

    @product = Product.create(params[:user][:product])
    if params[:user][:company_name].empty?
      @company = Company.find_by(id: params[:user][:product][:company_id])
      @company.products << @product
    else
      @company = Company.create(name: params[:user][:company_name])
      @company.products << @product
    end
      @company.save

      redirect to '/products'
  end

  get '/products/:slug' do
    @product = Product.find_by_slug(params[:slug])
    @company = @product.company
    erb :'/products/show'
  end

end
