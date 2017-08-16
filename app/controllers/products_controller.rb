class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/products'
  end

  get '/products/new' do
    erb :'/products/new'
  end

  post '/products' do
    @product = Product.find_or_create_by(params[:user][:product])
    if !params[:user][:company_name].empty?
      @company = Company.find_by(params[:user][:product][:company_id])
      @company.products << @product
    else
      @company = Company.create(name: params[:user][:company_name])
      @company.products << @product
    end
      @company.save
      redirect to '/products'
  end

  get '/products/:id' do
    @product = Product.find_by(id: params[:id])
    @company = @product.company
    erb :'/products/show'
  end

end
