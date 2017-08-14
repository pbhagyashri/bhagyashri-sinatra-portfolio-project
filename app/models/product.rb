class Product < ActiveRecord::Base
  include Slugifiable
  extend Slugifiable

  belongs_to :company
end
