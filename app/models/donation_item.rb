class DonationItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :reason
  belongs_to :donation

  def to_s
  	reason.nil? ? 'General Donation' : reason.title
  end
end
