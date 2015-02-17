class AddSuccessTitleToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :success_title, :string, before: :success_excerpt
  end
end
