class Donation < ActiveRecord::Base
  belongs_to :cart
  belongs_to :reason

  def to_s
  	reason.nil? ? 'General Donation' : reason.title
  end
end
