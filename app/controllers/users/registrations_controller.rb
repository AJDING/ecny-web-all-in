class Users::RegistrationsController < Devise::RegistrationsController
  protected

  # Devise normally requires the current password to change name/phone. Only require it for password/email changes.
  def update_resource(resource, params)
    if params[:password].blank? && (params[:email].blank? || params[:email] == resource.email)
      params.delete(:current_password)
      resource.update_without_password(params.except(:password, :password_confirmation))
    else
      super
    end
  end

  def after_update_path_for(resource)
    if resource.pending_reconfirmation?
      flash[:notice] = "Check #{resource.unconfirmed_email} for a confirmation link. Your email stays #{resource.email} until you click it."
    end
    edit_user_registration_path
  end
end
