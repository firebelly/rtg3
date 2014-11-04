class AddAttachmentImageToReasons < ActiveRecord::Migration
  def self.up
    change_table :reasons do |t|
      t.attachment :image
      t.attachment :secondary_image
    end
  end

  def self.down
    remove_attachment :reasons, :image
    remove_attachment :reasons, :secondary_image
  end
end
