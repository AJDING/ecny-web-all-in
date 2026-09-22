class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Account Settings never changes the password directly (that goes through an emailed link).
  # Name/phone save freely; changing the email requires the current password.
  def update_resource(resource, params)
    params = params.except(:password, :password_confirmation)
    if params[:email].blank? || params[:email] == resource.email
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def after_update_path_for(resource)
    if resource.pending_reconfirmation?
      flash[:notice] = "Check #{resource.unconfirmed_email} for a confirmation link. Your email stays #{resource.email} until you click it."
    end
    edit_user_registration_path
  end
end
