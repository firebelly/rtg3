class CreateSupporterTypes < ActiveRecord::Migration
  def change
    create_table :supporter_types do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
    add_index :supporter_types, :slug, :unique => true
  end
end
