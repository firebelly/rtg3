class AddExtraFieldsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :title_override, :string
    add_column :pages, :banner_title, :string
  end
end
