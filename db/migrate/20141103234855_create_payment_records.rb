class CreatePaymentRecords < ActiveRecord::Migration
  def change
    create_table :payment_records do |t|
      t.integer :order_id
      t.text :params

      t.timestamps
    end
  end
end
