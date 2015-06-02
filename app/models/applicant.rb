class Applicant < ActiveRecord::Base
	def full_name
	  [first_name,last_name].reject{ |e| e.empty? }.join ' '
	end

	def full_address
	  "#{full_name}
	  #{address}
	  #{city}, #{state} #{zip_code}"
	end
end
