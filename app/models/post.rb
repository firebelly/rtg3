class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  paginates_per 100

  default_scope -> {order('post_date DESC')}
  scope :published, -> {where(published: true)}

  belongs_to :post_type

  validates :title, presence: true
  validates :content, presence: true
  validates :post_type_id, presence: true

  before_save :set_post_date_to_now

  def should_generate_new_friendly_id?
    title_changed?
  end

  # default to News post type for new records
  after_initialize do
    if new_record?
      self.post_type ||= PostType.friendly.find('news')
      self.published ||= true
    end
  end

  # icon select list
  def icon_enum
    ['text', 'audio', 'video']
  end

  private

  def set_post_date_to_now
    self.post_date = Time.now if self.post_date.blank?
  end
end
