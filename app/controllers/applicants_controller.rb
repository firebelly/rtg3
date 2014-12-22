class ApplicantsController < ApplicationController

  def create
    @applicant = Applicant.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email],
      form: params[:form]
      )
    ApplicantMailer.new_applicant(@applicant).deliver
    flash[:notice] = 'Your application was received. You should receive an email shortly.'
    redirect_to :back
  end

  def contact
    @applicant = Applicant.create(
      first_name: params[:first_name],
      email: params[:email],
      form: params[:form],
      subject: params[:subject],
      message: params[:message]
      )
    ApplicantMailer.contact(@applicant).deliver
    flash[:notice] = 'Your email has been sent.'
    redirect_to :back
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

end
