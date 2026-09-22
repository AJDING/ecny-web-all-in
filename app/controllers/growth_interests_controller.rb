# Saves which categories a person wants to learn more about for one assessment.
# Replaces the set for that assessment each time (checkboxes on the results page).
class GrowthInterestsController < ApplicationController
  def update
    assessment = Assessment.find_by!(slug: params[:id])
    valid  = assessment.categories.keys
    chosen = Array(params[:categories]).map(&:to_s) & valid

    GrowthInterest.transaction do
      current_user.growth_interests.where(assessment: assessment).where.not(category: chosen).destroy_all
      chosen.each { |c| GrowthInterest.find_or_create_by!(user: current_user, assessment: assessment, category: c) }
    end
    current_user.growth_interests.reset

    redirect_to results_assessment_path(assessment), notice: chosen.any? ? "Saved. We'll bring these to your gathering." : "Saved."
  end
end
