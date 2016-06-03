class PageImage < ActiveRecord::Base
  belongs_to :page, touch: true
  has_attached_file :image, 
  	styles: { large: "1800x", medium: "900x570#", thumb: "600x380#" },
  	convert_options: { large: "-quality 60", medium: "-quality 65", thumb: "-quality 65" }

  default_scope { order('position ASC') }

  validates :image, :presence => true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }
end
