class AssessmentsController < ApplicationController
  before_action :set_assessment, only: %i[show create results]
  before_action :require_unlocked, only: %i[show create]

  def index
    redirect_to my_progress_path
  end

  def show
    @questions = @assessment.questions
    @existing  = current_user.result_for(@assessment)
  end

  def create
    result = AssessmentResult.build_from(user: current_user, assessment: @assessment, answers: params.fetch(:answers, {}).to_unsafe_h)
    if result.complete? && result.save
      current_user.assessment_results.reset
      Appointment.find_or_create_by!(user: current_user) if pathway.reload_if_possible.assess_complete?
      redirect_to results_assessment_path(@assessment), notice: "#{@assessment.title} complete."
    else
      @questions = @assessment.questions
      @existing  = result
      flash.now[:alert] = "Answer every question to see your results."
      render :show, status: :unprocessable_entity
    end
  end

  def results
    @result = current_user.result_for(@assessment)
    redirect_to assessment_path(@assessment) and return unless @result&.complete?
    @ranked = @assessment.ranked(@result)
  end

  # Personal Ministry Plan — every completed result on one page.
  def plan
    @results = current_user.assessment_results.includes(:assessment).select(&:complete?)
      .sort_by { |r| r.assessment.position }
  end

  private

  def set_assessment
    @assessment = Assessment.find_by!(slug: params[:id])
  end

  def require_unlocked
    return if pathway.assessment_unlocked?(@assessment)
    redirect_to my_progress_path, alert: "Finish Step One to unlock the assessments."
  end
end
