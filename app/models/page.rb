class Page < ActiveRecord::Base
  extend FriendlyId
  has_many :page_images
  accepts_nested_attributes_for :page_images, :allow_destroy => true 
  friendly_id :title, use: :slugged

  has_attached_file :image, 
    styles: { 
      thumb:            "600x380#", 
      medium:           "900x575", 
      mobile_wallpaper: "640x1136#",
      wallpaper:        "1800x1000>"
      },
    convert_options: {
      thumb:            "-quality 70 -strip",
      medium:           "-quality 70 -strip",
      mobile_wallpaper: "-quality 60 -strip",
      wallpaper:        "-quality 60 -strip"
    }

  validates_attachment_content_type [:image], :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :title, presence: true
  validates :content, presence: true
  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }
end
