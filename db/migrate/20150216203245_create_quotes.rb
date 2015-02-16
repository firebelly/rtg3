class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.references :page
      t.text :quote
      t.string :quotee
      t.string :title
      t.string :location
      t.integer :position

      t.timestamps null: false
    end
    add_index :quotes, :page_id
  end
end
