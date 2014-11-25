class Supporter < ActiveRecord::Base
  has_attached_file :logo, styles: { 
      thumb: "300x150"
    },
    convert_options: {
      thumb: "-modulate 100,0 +level-colors '#b9b9b9,#7c7c7c'",
    }
  validates_attachment_content_type [:logo], :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  belongs_to :supporter_type
end
