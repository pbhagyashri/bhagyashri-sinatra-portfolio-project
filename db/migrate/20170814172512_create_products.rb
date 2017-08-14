class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.string :countries_of_use
      t.string :active_ingredients
      t.string :products_application
      t.integer :company_id
    end
  end
end
