class CreateReasonImages < ActiveRecord::Migration
  def change
    create_table :reason_images do |t|
      t.references :reason
      t.has_attached_file :image
      t.integer :position
      t.timestamps
    end
  end
end
