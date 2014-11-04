class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :session_id
      t.integer :order_id

      t.timestamps  
    end
  end
end