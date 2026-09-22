# Aggregate view across ALL registered people: funnel, average score per category
# for every assessment, and "learn more" demand. Computed in Ruby from the jsonb
# scores — fine for thousands of people; move to SQL if it ever gets slow.
class Admin::InsightsController < Admin::BaseController
  def index
    @people_total     = User.count
    @step_one_done    = User.joins(:lesson_completions).group("users.id")
                            .having("COUNT(lesson_completions.id) >= ?", Lesson.published.count).count.size
    @assessments      = Assessment.ordered.to_a
    results           = AssessmentResult.where.not(completed_at: nil).includes(:assessment).to_a
    @results_by_assmt = results.group_by(&:assessment_id)
    @all_three_done   = results.group_by(&:user_id).count { |_, rs| rs.size >= @assessments.size }
    @rsvps            = Appointment.where(status: %w[scheduled completed]).count

    # { assessment_id => [[category, avg_pct, n, times_in_top, learn_more_count], ...] sorted high→low }
    interest_counts = GrowthInterest.group(:assessment_id, :category).count
    @category_stats = @assessments.to_h do |a|
      rs = @results_by_assmt[a.id] || []
      rows = a.categories.keys.map do |cat|
        vals = rs.map { |r| r.scores[cat] }.compact
        avg  = vals.empty? ? 0 : (vals.sum.to_f / vals.size).round
        tops = rs.count { |r| r.top.map(&:first).include?(cat) }
        [cat, avg, vals.size, tops, interest_counts[[a.id, cat]].to_i]
      end
      [a.id, rows.sort_by { |row| -row[1] }]
    end
  end
end
