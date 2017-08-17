class User < ActiveRecord::Base
  has_secure_password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_many :companies
  has_many :products, through: :companies
end
