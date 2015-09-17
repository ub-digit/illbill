class AddColumnSigelToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :sigel, :text
  end
end
