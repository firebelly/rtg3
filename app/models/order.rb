class Order < ActiveRecord::Base
  has_many :payment_records
  has_one :cart

  # generate order before sending off to paypal
  # def add_order_items(items)
  #   items.each do |item|
  #     OrderItem.create(
  #       :item_id => item.item_id,
  #       :order_id => self.id,
  #       :price => item.price
  #     )
  #   end
  # end

  # payment went through, adjust each reason's donated amount
  def finalize_order_items
    cart.donations.each do |donation|
      donation.reason.update_attributes(:total_donated => donation.reason.total_donated + donation.price)
    end
  end

  def billing_name
    [billing_first_name, billing_last_name].join(' ')
  end

  def shipping_name
    [shipping_first_name, shipping_last_name].join(' ')
  end

  def found_text
    found == 'other' ? found_other : found
  end

end