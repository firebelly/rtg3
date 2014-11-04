class PaymentRecord < ActiveRecord::Base
	belongs_to :order
end
