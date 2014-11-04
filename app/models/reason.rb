class Reason < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_attached_file :image, styles: { large: "1800x", medium: "900x575", thumb: "600x380#" }
  has_attached_file :secondary_image, styles: { medium: "900x575" }
  validates_attachment_content_type [:image,:secondary_image], :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_many :reason_images
  has_many :donations

  attr_accessor :delete_secondary_image
  before_validation { self.secondary_image.clear if self.delete_secondary_image == '1' }

  validates :title, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :reason_images, :allow_destroy => true 

  before_create :set_post_date_to_now

  scope :published, -> { where(published: true) }
  scope :promoted, -> { where(promoted: true) }
  scope :is_success, -> { where(is_success: true) }
  scope :fulfilled, -> { where("total_donated >= total_needed") }

  private

  def set_post_date_to_now
    self.post_date = Time.now if self.post_date.nil?
  end

  def fulfilled
    self.total_donated >= self.total_needed
  end

end