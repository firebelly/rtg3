class ApplicantMailer < ActionMailer::Base
	layout 'emails'

  def new_applicant(applicant)
    @applicant = applicant
    mail(subject: "New Applicant for %s from %s" % [@applicant.form, @applicant.full_name])
  end

  def new_contact(applicant)
    @applicant = applicant
    mail(subject: "New Contact Email for %s from %s" % [@applicant.form, @applicant.full_name])
  end

  def new_volunteer(applicant)
    @applicant = applicant
    mail(subject: "New %s from %s" % [@applicant.form, @applicant.full_name])
  end

end
