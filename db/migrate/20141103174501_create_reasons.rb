class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :title
      t.string :slug
      t.date :post_date
      t.text :excerpt
      t.text :content
      t.decimal :total_needed, precision: 10, scale: 2, default: 0
      t.decimal :total_donated, precision: 10, scale: 2, default: 0
      t.boolean :published
      t.boolean :promoted
      t.boolean :is_success
      t.text :success_excerpt
      t.text :success_content

      t.timestamps
    end
    add_index :reasons, :slug, unique: true
  end
end
