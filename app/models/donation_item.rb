class DonationItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :reason
  belongs_to :donation

  def name
    title = reason.nil? ? 'General Donation' : reason.title
    "title: $%.2f" % amount
  end
end
