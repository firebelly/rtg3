class Donation < ActiveRecord::Base
	belongs_to :cart
	belongs_to :reason
end
