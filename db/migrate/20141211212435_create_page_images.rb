class CreatePageImages < ActiveRecord::Migration
  def change
    create_table :page_images do |t|
      t.references :page
      t.has_attached_file :image
      t.string :caption
      t.integer :position
      t.timestamps
    end
  end
end
