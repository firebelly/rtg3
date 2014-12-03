class ApplicantsController < ApplicationController

  def create
    @applicant = Applicant.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email],
      form: params[:form],
      params: params.except(:first_name, :last_name, :phone, :email, :form, :authenticity_token, :utf8, :action, :controller)
      )
    ApplicantMailer.new_applicant(@applicant).deliver
    flash[:notice] = 'Your application was received. You should receive an email shortly.'
    redirect_to :back
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

end
