class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.string :title
      t.string :url
      t.references :supporter_type
      t.attachment :logo

      t.timestamps
    end
  end
end
