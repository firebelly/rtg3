class Cart < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  belongs_to :order

  def count
    donations.count
  end

  def total
    donations.sum(:amount)
  end

  def self.cleanup
  	self.where("created_at < ? AND order_id IS NULL", 14.days.ago).delete_all
  end
end
