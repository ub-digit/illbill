class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :lf_number
      t.string :json
      t.integer :price
      t.boolean :invoiced
      t.timestamps null: false
    end
  end
end
