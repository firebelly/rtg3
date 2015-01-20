class RenameDonationAndOrderTables < ActiveRecord::Migration
  def up
    rename_table :donations, :donation_items
    rename_table :orders, :donations
    rename_column :payment_records, :order_id, :donation_id
    
    add_column :donation_items, :donation_id, :integer
    remove_column :carts, :order_id

    # indices!
    add_index :donation_items, :reason_id
    add_index :donation_items, :cart_id
    add_index :donation_items, :donation_id

    # delete all current junk data and start fresh
    Cart.delete_all
    DonationItem.delete_all
    Donation.delete_all
  end
  def down
    remove_column :donation_items, :donation_id
    add_column :carts, :order_id, :integer

    rename_column :donation_items, :donation_id, :order_id
    rename_column :payment_records, :donation_id, :order_id
    rename_table :donations, :orders
    rename_table :donation_items, :donations
  end
end
