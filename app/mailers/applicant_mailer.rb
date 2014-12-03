class ApplicantMailer < ActionMailer::Base

  def new_applicant(applicant)
    @applicant = applicant
    mail(subject: "New Applicant for %s" % @applicant.form)
  end

  def contact(applicant)
    @applicant = applicant
    mail(subject: "New Contact Email for %s" % @applicant.form)
  end

end
