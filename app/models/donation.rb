class Donation < ActiveRecord::Base
  has_many :payment_records
  has_many :donation_items, dependent: :destroy

  # payment went through, adjust each reason's donated amount
  def finalize_donation_items
    donation_items.each do |donation_item|
      unless donation_item.reason.nil?
        new_total_donated = donation_item.reason.total_donated + donation_item.amount
        donation_item.reason.update_attributes(:total_donated => new_total_donated)
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