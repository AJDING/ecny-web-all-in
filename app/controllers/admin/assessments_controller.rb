class Admin::AssessmentsController < Admin::BaseController
  def index
    @assessments = Assessment.ordered.includes(:questions)
  end

  def show
    @assessment = Assessment.find_by!(slug: params[:id])
    @questions  = @assessment.questions
  end
end
