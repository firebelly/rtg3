class Quote < ActiveRecord::Base
  belongs_to :page

  default_scope { order('position ASC') }

  def quote_short
    "%s (%s)" % [quote.gsub(/^(.{25,}?).*$/m,'\1...'), quotee]
  end
end
