class ApplicantsController < ApplicationController

  def create
    contact_details = params[:contact_first].blank? ? "Contact me first. " : ''
    contact_details += "Preferred contact: %s" % params[:best_contact]
    
    @applicant = Applicant.create(
      form: params[:form],
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone: params[:phone],
      email: params[:email],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      contact_details: contact_details
      )
    ApplicantMailer.new_applicant(@applicant).deliver_now
    flash[:notice] = 'Your request for information was received.'
    redirect_to 'https://docs.google.com/a/firebellydesign.com/forms/d/1PuuCyLCfiE0y13xChbn4vcTg4r4UPyaZMNGz2BbqxZk/viewform'
  end

  def contact
    @applicant = Applicant.create(
      first_name: params[:first_name],
      email: params[:email],
      form: params[:form],
      subject: params[:subject],
      message: params[:message]
      )
    ApplicantMailer.contact(@applicant).deliver_now
    flash[:notice] = 'Your request for information was received'
    redirect_to :back
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

end
