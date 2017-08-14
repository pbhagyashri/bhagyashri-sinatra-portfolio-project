class Company < ActiveRecord::Base

  include Slugifiable
  extend Slugifiable

  belongs_to :user
  has_many :products
end
