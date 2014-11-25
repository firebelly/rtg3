class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	default_scope -> {order('post_date DESC')}
	scope :published, -> {where(published: true)}

	belongs_to :post_type

	validates :title, presence: true
	validates :content, presence: true
	validates :post_type_id, presence: true

	before_create :set_post_date_to_now

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
	  post_date = Time.now if post_date.nil?
	end
end
