class AddAddressFieldsToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :address, :string, after: :last_name
    add_column :donations, :city, :string, after: :address
    add_column :donations, :state, :string, after: :city
  end
end
