class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc)
    @users = @users.where("email ILIKE :q OR first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    @users = @users.limit(200)
  end

  def show
    @user    = User.find(params[:id])
    @pathway = Pathway.new(@user)
    @results = @user.assessment_results.includes(:assessment).select(&:complete?)
  end
end
