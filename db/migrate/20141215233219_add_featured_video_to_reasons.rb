class AddFeaturedVideoToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :featured_video, :string
  end
end
