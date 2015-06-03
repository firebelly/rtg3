class DonationMailer < ActionMailer::Base
	layout 'emails'

  def new_donation(donation)
    @donation = donation
    mail(to: @donation.email, from: 'info@reasontogive.com', subject: "Thank you for giving")
  end

  def new_donation_for_admin(donation)
    @donation = donation
    mail(subject: "A donation of $%.2f was received from %s" % [@donation.total, @donation.full_name])
  end

end