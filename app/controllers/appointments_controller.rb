class AppointmentsController < ApplicationController
  before_action :require_unlocked

  def show
    @appointment = Appointment.find_or_create_by!(user: current_user)
  end

  # The person books on the external scheduler, then confirms here.
  def create
    @appointment = Appointment.find_or_create_by!(user: current_user)
    @appointment.update!(status: "scheduled", meeting_preference: params[:meeting_preference].presence,
                         scheduled_at: params[:scheduled_at].presence)
    current_user.update!(pathway_completed_at: Time.current) if current_user.pathway_completed_at.nil?
    PlanningCenterHandoffJob.perform_later(current_user.id) if ENV["PCO_APP_ID"].present?
    redirect_to root_path, notice: "You're all in. See you at the gathering."
  end

  private

  def require_unlocked
    return if current_user.admin?
    return if pathway.meet_unlocked?
    redirect_to my_progress_path, alert: "Complete all three assessments to unlock the gathering RSVP."
  end
end
