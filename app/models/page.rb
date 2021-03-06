class Page < ActiveRecord::Base
  extend FriendlyId
  has_many :page_images
  has_many :quotes
  accepts_nested_attributes_for :page_images, :allow_destroy => true 
  accepts_nested_attributes_for :quotes, :allow_destroy => true 
  friendly_id :title, use: :slugged

  has_attached_file :image, styles: { large: "1800x", medium: "900x570#", thumb: "600x380#" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validates :title, presence: true
  validates :content, presence: true

  def should_generate_new_friendly_id?
    title_changed?
  end

  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }
end
