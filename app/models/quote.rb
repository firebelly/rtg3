class Quote < ActiveRecord::Base
  belongs_to :page

  default_scope { order('position ASC') }

  validates :quote, presence: true
  validates :quotee, presence: true

  def quote_short
    quote.blank? ?  '' : "%s (%s)" % [quote.gsub(/^(.{25,}?).*$/m,'\1...'), quotee]
  end
end
