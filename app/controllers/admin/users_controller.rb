require "csv"

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc)
    @users = @users.where("email ILIKE :q OR first_name ILIKE :q OR last_name ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
    @page  = [params[:page].to_i, 1].max
    @per   = 50
    @total = @users.count
    @users = @users.offset((@page - 1) * @per).limit(@per)

    respond_to do |format|
      format.html
      format.csv do
        rows = User.order(:created_at).map do |u|
          p = Pathway.new(u)
          [u.first_name, u.last_name, u.email, u.phone, u.created_at.to_date, "#{p.percent}%",
           p.learn_complete?, p.assess_complete?, u.appointment&.status,
           u.strengths.map { |a, top| "#{a.title}: #{top.map(&:first).join('/')}" }.join(" | "),
           u.growth_areas.map { |a, cats| "#{a.title}: #{cats.join('/')}" }.join(" | ")]
        end
        csv = (["First", "Last", "Email", "Phone", "Joined", "Progress", "Step1 done", "Assessments done", "RSVP", "Strengths", "Learn more"].to_csv +
               rows.map(&:to_csv).join)
        send_data csv, filename: "all-in-people-#{Date.current}.csv"
      end
    end
  end

  def show
    @user    = User.find(params[:id])
    @pathway = Pathway.new(@user)
    @results = @user.assessment_results.includes(:assessment).select(&:complete?)
  end
end
