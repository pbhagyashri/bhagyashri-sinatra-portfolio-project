class ChangeColumnProduct < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :type, :category
  end
end
