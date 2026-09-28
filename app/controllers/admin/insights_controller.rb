# Aggregate view across ALL registered people. index = funnel + links; show = one assessment
# (or the combined "full design") with average score per category, the capacity pie, and the
# people with the greatest capacity in each category. Computed in Ruby from the jsonb scores —
# fine for thousands of people; move to SQL if it ever gets slow.
class Admin::InsightsController < Admin::BaseController
  FULL = "full-design".freeze

  def index
    @people_total    = User.count
    lessons_total    = Lesson.published.count
    @step_one_done   = lessons_total.zero? ? 0 :
                       User.joins(:lesson_completions).group("users.id").having("COUNT(lesson_completions.id) >= ?", lessons_total).count.size
    @assessments     = Assessment.ordered.to_a
    results          = completed_results
    @completed_by    = results.group_by(&:assessment_id).transform_values(&:size)
    @all_three_done  = results.group_by(&:user_id).count { |_, rs| rs.size >= @assessments.size }
    @rsvps           = Appointment.where(status: %w[scheduled completed]).count
  end

  def show
    @assessments = Assessment.ordered.to_a
    results      = completed_results

    if params[:id] == FULL
      @title    = "Your full design (everyone)"
      @subtitle = "Every category from all #{@assessments.size} assessments, averaged across everyone who completed that assessment."
      @rows     = @assessments.flat_map { |a| category_rows(a, results.select { |r| r.assessment_id == a.id }, label_suffix: " · #{a.title}") }
                              .sort_by { |row| -row[:avg] }
      @top_n    = 5
      @count    = results.map(&:user_id).uniq.size
      @full     = true
    else
      @assessment = Assessment.find_by!(slug: params[:id])
      rs          = results.select { |r| r.assessment_id == @assessment.id }
      @title      = @assessment.title
      @subtitle   = "Average score per category across everyone who completed this assessment."
      @rows       = category_rows(@assessment, rs).sort_by { |row| -row[:avg] }
      @top_n      = @assessment.top_n
      @count      = rs.size
      @full       = false
    end
    @interest_counts = GrowthInterest.group(:assessment_id, :category).count
  end

  private

  def completed_results
    AssessmentResult.where.not(completed_at: nil).includes(:assessment, :user).to_a
  end

  # Only people at or above this score are listed as "greatest capacity" for a category.
  CAPACITY_THRESHOLD = 99

  # One row per category: label, avg (0-100), n, everyone at/above the threshold (high→low), learn-more count.
  def category_rows(assessment, rs, label_suffix: "")
    assessment.categories.keys.map do |cat|
      scored = rs.map { |r| [r.user, r.scores[cat]] }.reject { |_, s| s.nil? }
      avg    = scored.empty? ? 0 : (scored.sum { |_, s| s }.to_f / scored.size).round
      top    = scored.select { |_, s| s >= CAPACITY_THRESHOLD }.sort_by { |u, s| [-s, u.last_name.to_s, u.first_name.to_s] }
      best   = scored.max_by { |_, s| s }&.last
      { assessment: assessment, category: cat, label: "#{cat}#{label_suffix}", avg: avg, n: scored.size, top: top, best: best }
    end
  end
end
