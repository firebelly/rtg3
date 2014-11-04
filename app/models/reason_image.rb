class ReasonImage < ActiveRecord::Base
  belongs_to :reason
  has_attached_file :image, :styles => { :large => "1800x", :medium => "900x575", :thumb => "600x380#" }

  default_scope { order('position ASC') }

  validates :image, :presence => true
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
