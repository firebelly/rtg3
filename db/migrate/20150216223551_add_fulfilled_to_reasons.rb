class AddFulfilledToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :fulfilled, :boolean, after: :is_success, default: false
  end
end
