# After a person clicks the confirmation link (email change or new address), sign out whichever
# session is open in that browser and send them to the sign-in page. Otherwise the link would
# confirm one account while a different account stays logged in.
class Users::ConfirmationsController < Devise::ConfirmationsController
protected

def after_confirmation_path_for(resource_name, resource)
sign_out_all_scopes
flash[:notice] = "Your email is confirmed. Please sign in with your new email address."
new_session_path(resource_name)
end
end
