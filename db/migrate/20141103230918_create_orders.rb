class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :payment_type
      t.string :payment_status
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :zip
      t.boolean :newsletter, default: false
      t.decimal :total, precision: 10, scale: 2, default: 0
      t.string :found
      t.string :found_other
      t.text :notes

      t.timestamps
    end
  end
end
