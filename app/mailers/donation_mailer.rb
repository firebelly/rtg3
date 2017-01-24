class DonationMailer < ActionMailer::Base
  layout 'emails'

  def new_donation(donation)
    @donation = donation
    mail(to: @donation.email, subject: "Thank you for giving")
  end

  def new_donation_for_admin(donation)
    @donation = donation
    mail(to: "#{ENV['EMAILS_TO']},dawn@firebellydesign.com",
         reply_to: @donation.email,
         subject: "A donation of $%.2f was received from %s" % [@donation.total, @donation.full_name])
  end

end
