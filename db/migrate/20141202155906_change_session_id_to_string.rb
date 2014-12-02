class ChangeSessionIdToString < ActiveRecord::Migration
  def change
  	change_column :carts, :session_id, :string
  end
end
