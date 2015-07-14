class Applicant < ActiveRecord::Base
  def full_name
    [first_name,last_name].reject{ |e| e.blank? }.join ' '
  end

  def full_address
    if address.blank? && city.blank?
      full_name
    else
      "#{full_name}
      #{address}
      #{city}, #{state} #{zip_code}"
    end
  end
end
