class CreatePostTypes < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :post_types, :slug, :unique => true
  end
end
