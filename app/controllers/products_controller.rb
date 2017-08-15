class ProductsController < ApplicationController

  get '/products' do
    erb :'/products/products'
  end

  get '/products/new' do
    erb :'/products/new'
  end

  post '/products' do
    binding.pry
    redirect to '/products'
  end

end
