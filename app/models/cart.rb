class Cart < ActiveRecord::Base
  has_many :donations, :dependent => :destroy
  belongs_to :order
end
