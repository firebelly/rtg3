class ReasonImage < ActiveRecord::Base
  belongs_to :reason
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

  default_scope { order('position ASC') }

  validates :image, :presence => true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
