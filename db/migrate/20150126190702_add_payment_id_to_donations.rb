class AddPaymentIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :payment_id, :string, after: :id
  end
end
