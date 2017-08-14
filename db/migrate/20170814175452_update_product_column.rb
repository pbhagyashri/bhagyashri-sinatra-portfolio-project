class UpdateProductColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :products_application, :product_application
  end
end
