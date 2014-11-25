class Cart < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  belongs_to :order

  def count
    donations.count
  end

  def total
    donations.sum(:amount)
  end

end
