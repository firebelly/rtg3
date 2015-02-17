class ApplicantMailer < ActionMailer::Base
	layout 'emails'

  def new_applicant(applicant)
    @applicant = applicant
    mail(subject: "New Applicant for %s from %s" % [@applicant.form, @applicant.full_name])
  end

  def contact(applicant)
    @applicant = applicant
    mail(subject: "New Contact Email for %s from %2" % [@applicant.form, @applicant.full_name])
  end

end
