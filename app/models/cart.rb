class Cart < ActiveRecord::Base
  has_many :donation_items
  belongs_to :order

  def count
    donation_items.count
  end

  def total
    donation_items.sum(:amount)
  end

  def self.cleanup
    self.where("created_at < ?", 30.days.ago).delete_all
  	DonationItem.where("created_at < ? AND donation_id IS NULL", 30.days.ago).delete_all
  end
end
