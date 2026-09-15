class Admin::AppointmentsController < Admin::BaseController
  def index
    @appointments = Appointment.includes(:user).order(updated_at: :desc)
  end

  def update
    a = Appointment.find(params[:id])
    a.update!(params.require(:appointment).permit(:status, :notes, :scheduled_at))
    redirect_to admin_appointments_path, notice: "Updated #{a.user.full_name}."
  end
end
