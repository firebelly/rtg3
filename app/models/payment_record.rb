class PaymentRecord < ActiveRecord::Base
  belongs_to :donation
end
