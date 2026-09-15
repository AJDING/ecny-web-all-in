class Admin::BaseController < ApplicationController
  before_action :require_admin
  layout "admin"

  private

  def require_admin
    redirect_to root_path, alert: "Admins only." unless current_user.admin?
  end
end
