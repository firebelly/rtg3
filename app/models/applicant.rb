class Applicant < ActiveRecord::Base
	def full_name
	  [first_name,last_name].reject{ |e| e.empty? }.join ' '
	end
end
