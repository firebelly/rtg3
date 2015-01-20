class Donation < ActiveRecord::Base
  has_many :payment_records
  has_many :donation_items, dependent: :destroy

  # payment went through, adjust each reason's donated amount
  def finalize_order_items
    cart.donation_items.each do |donation_item|
      unless donation_item.reason.nil?
        donation_item.reason.update_attributes(:total_donated => donation_item.reason.total_donated + donation_item.price)
      end
    end
  end

  def found_text
    found == 'other' ? found_other : found
  end

  def donated_to
    donation_items.collect{|d| d }.join(', ')
  end

end