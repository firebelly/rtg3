class AddCaptionToReasonImage < ActiveRecord::Migration
  def change
    add_column :reason_images, :caption, :string
  end
end
