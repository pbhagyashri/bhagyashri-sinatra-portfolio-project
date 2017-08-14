class User < ActiveRecord::Base
  has_many :companies
  has_many :products, through: :companies
end
