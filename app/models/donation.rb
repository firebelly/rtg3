class Donation < ActiveRecord::Base
  has_many :payment_records
  has_many :donation_items, -> { includes :reason }, dependent: :destroy
  has_many :reasons, through: :donation_items

  # payment went through, adjust each reason's donated amount
  def finalize_donation_items
    donation_items.each do |donation_item|
      unless donation_item.reason.nil?
        new_total_donated = donation_item.reason.total_donated + donation_item.amount
        donation_item.reason.update_attributes(:total_donated => new_total_donated)
      end
    end
  end

  def self.found_options
    [
      "I've donated before",
      "I know Firebelly Design",
      "I am/was a volunteer",
      "Word of mouth",
      "Through social media",
      "A link from another site",
      "I was searching the web",
      "At an event I attended",
      "In the news",
      "Other"
    ]
  end

  def found_text
    found == 'other' ? found_other : found
  end

  def full_address
    "#{first_name} #{last_name}<br>
    #{address}<br>
    #{city}, #{state}  #{zip}".html_safe
  end

  def total
    donation_items.sum(:amount)
  end

end