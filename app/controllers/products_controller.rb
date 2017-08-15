class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/products'
  end

  get '/products/new' do

    erb :'/products/new'
  end

  post '/products' do

    @product = Product.find_or_create_by(params[:user][:product])
    redirect to '/products'
  end

end
