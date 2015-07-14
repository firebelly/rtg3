class ApplicantsController < ApplicationController

  def create
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
      contact_preference: params[:contact_preference]
      )
    ApplicantMailer.new_applicant(@applicant).deliver_now
    flash[:notice] = 'Your request for information was received.'
    google_form_params = {
      'entry.2055828340' => @applicant.full_name, 
      'entry.1250369102' => @applicant.phone,
      'entry.1544329668' => @applicant.email,
      'entry.782633025' => @applicant.address,
      'entry.1935881909' => @applicant.zip_code
    }.to_query
    redirect_to "https://docs.google.com/a/firebellydesign.com/forms/d/1PuuCyLCfiE0y13xChbn4vcTg4r4UPyaZMNGz2BbqxZk/viewform?%s" % google_form_params
  end

  def contact
    @applicant = Applicant.create(
      first_name: params[:first_name],
      email: params[:email],
      form: params[:form],
      subject: params[:subject],
      message: params[:message]
      )
    ApplicantMailer.new_contact(@applicant).deliver_now
    flash[:notice] = 'Your request for information was received'
    redirect_to :back
  end

  def volunteer
    @applicant = Applicant.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone: params[:phone],
      form: params[:form]
      )
    ApplicantMailer.new_volunteer(@applicant).deliver_now
    flash[:notice] = 'Your request for information was received'
    google_form_params = {
      'entry.1803540405' => @applicant.full_name, 
      'entry.194360264' => @applicant.phone,
      'entry.218243436' => @applicant.email
    }.to_query
    redirect_to "https://docs.google.com/a/firebellydesign.com/forms/d/1TbAFDoOZJJs34db9jhSCJgwuIrwSd5ypbxiX9xMqpZg/viewform?%s" % google_form_params
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

end
