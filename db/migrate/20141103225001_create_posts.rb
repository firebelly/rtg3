class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.date :post_date
      t.boolean :published
      t.references :post_type

      t.timestamps
    end
    add_index :posts, :slug, :unique => true
  end
end
