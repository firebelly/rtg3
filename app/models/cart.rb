class Cart < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  belongs_to :order

  # def add_donation(donation_id, amount)
  #   if donation_id.nil?
  #     donation = donation.generic_donation
  #   else
  #     donation = donation.find(donation_id.to_i)
  #   end

  #   if !amount.nil?
  #     price = BigDecimal.new(amount)
  #   else
  #     price = donation.price
  #   end
  
  #   # in cart?
  #   if cart_donation = self.donations.find_by_donation_id(donation.id)
  #     cart_donation.price += price
  #     cart_donation.save
  #   else
  #     cart_donation = self.donations.create(:donation_id => donation.id, :price => price)
  #   end
  #   cart_donation
  # end
  
  # def subtotal
  #   self.donations.map(&:price).reduce(:+).to_f
  # end

end
