class Reason < ActiveRecord::Base
  extend FriendlyId
  friendly_id :reason_slug, use: [:slugged, :history]

  has_many :reason_images
  has_many :donation_items
  accepts_nested_attributes_for :reason_images, :allow_destroy => true 
  before_save :set_post_date_to_now
  default_scope -> {order('post_date DESC')}

  has_attached_file :image, 
    styles: { large: "1800x", medium: "900x570#", thumb: "600x380#" },
    convert_options: { large: "-quality 60", medium: "-quality 65", thumb: "-quality 65" }
  has_attached_file :secondary_image, styles: { medium: "900x570#" },
    convert_options: { medium: "-quality 60" }

  validates_attachment_content_type [:image,:secondary_image], :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }
  attr_accessor :delete_secondary_image
  before_validation { self.secondary_image.clear if self.delete_secondary_image == '1' }

  validates :title, presence: true
  validates :donation_prompt, presence: true
  validates :content, presence: true

  scope :published, -> { where(published: true) }
  scope :promoted, -> { where(promoted: true) }
  scope :not_success, -> { where(is_success: false) }
  scope :is_success, -> { where(is_success: true) }
  scope :unfulfilled, -> { where(fulfilled: false) }
  scope :fulfilled, -> { where(fulfilled: true) }

  def reason_slug
    fulfilled? ? reason_or_success_title : title
  end

  def reason_or_success_title
    (is_success? && !success_title.blank?) ? success_title : title
  end

  def should_generate_new_friendly_id?
    title_changed? || success_title_changed? || fulfilled_changed? || is_success_changed?
  end

  # default values for new records
  after_initialize do
    if new_record?
      self.content = "<h3>My Story</h3><p>Lorem ipsum</p><h3>My Goals</h3><p>Lorem ipsum</p><h3>How You Can Help</h3><p>Lorem ipsum</p>"
      self.success_content = "<h3>My Story</h3><p>Lorem ipsum</p><h3>My Goals</h3><p>Lorem ipsum</p><h3>How You Helped</h3><p>Lorem ipsum</p>"
      self.donation_prompt = "Why not support ____ by giving whatever you can"
    end
  end

  def percent_fulfilled(thanks_amount = 0)
    return 0 if total_needed == 0
    [((total_donated - thanks_amount) / total_needed * 100).round(2), 100].min
  end

  private

  def set_post_date_to_now
    self.post_date = Time.now if self.post_date.blank?
  end

end
