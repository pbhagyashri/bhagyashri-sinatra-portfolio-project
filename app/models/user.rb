class User < ActiveRecord::Base
  has_secure_password

  include Slugifiable
  extend Slugifiable

  has_many :companies
  has_many :products, through: :companies
end
