class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

  has_many :companies
  has_many :products, through: :companies
end
