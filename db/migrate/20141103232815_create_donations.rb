class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :cart_id
      t.integer :reason_id
      t.decimal :amount, precision: 10, scale: 2, default: 0

      t.timestamps
    end
  end
end