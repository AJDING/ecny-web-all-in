class Admin::DashboardController < Admin::BaseController
  def index
    @users_count      = User.count
    @completed_count  = User.where.not(pathway_completed_at: nil).count
    @scheduled_count  = Appointment.where(status: "scheduled").count
    @recent_users     = User.order(created_at: :desc).limit(10)
    @lessons          = Lesson.ordered
  end
end
