# Computes what a user can see, what is locked, and what their next step is.
# Mirrors the Connect app: Step 1 lessons unlock sequentially; Step 2 unlocks
# when Step 1 is complete; Step 3 unlocks when all assessments are complete.
class Pathway
  Item = Struct.new(:record, :status, keyword_init: true) # status: :complete | :current | :locked

  attr_reader :user

  def initialize(user)
    @user = user
  end

  # Drop memoised state after a write in the same request.
  def reload_if_possible
    @lesson_items = @assessment_items = nil
    user.assessment_results.reset
    self
  end

  def steps        = @steps        ||= Step.ordered.includes(lessons: { thumbnail_attachment: :blob }, assessments: :questions).to_a
  def learn_step   = steps.find { |s| s.slug == "learn" }
  def assess_step  = steps.find { |s| s.slug == "assess" }
  def meet_step    = steps.find { |s| s.slug == "meet" }

  def seeded?      = learn_step && assess_step && meet_step
  def lessons      = @lessons ||= (learn_step ? learn_step.lessons.select(&:published) : [])
  def assessments  = @assessments ||= (assess_step ? assess_step.assessments.to_a : [])

  # ----- Step 1 -----
  def lesson_items
    @lesson_items ||= begin
      unlocked = true
      lessons.map do |l|
        done = user.completed?(l)
        status = done ? :complete : (unlocked ? :current : :locked)
        unlocked = false unless done
        Item.new(record: l, status: status)
      end
    end
  end

  def lesson_unlocked?(lesson)
    lesson_items.find { |i| i.record.id == lesson.id }&.status != :locked
  end

  def lessons_done  = lesson_items.count { |i| i.status == :complete }
  def lessons_total = lessons.size
  def learn_complete? = lessons_total.positive? && lessons_done == lessons_total

  def next_lesson_after(lesson)
    idx = lessons.index { |l| l.id == lesson.id }
    lessons[idx + 1]
  end

  def previous_lesson(lesson)
    idx = lessons.index { |l| l.id == lesson.id }
    idx.positive? ? lessons[idx - 1] : nil
  end

  # ----- Step 2 -----
  def assessment_items
    @assessment_items ||= assessments.map do |a|
      r = user.result_for(a)
      status = if r&.complete? then :complete
               elsif learn_complete? then :current
               else :locked
               end
      Item.new(record: a, status: status)
    end
  end

  def assessment_unlocked?(assessment) = learn_complete?
  def assessments_done  = assessment_items.count { |i| i.status == :complete }
  def assess_complete?  = assessments.any? && assessments_done == assessments.size

  # ----- Step 3 -----
  def meet_unlocked? = assess_complete?
  def appointment    = user.appointment
  def complete?      = meet_unlocked? && appointment&.scheduled?

  # ----- "My Next Step" card -----
  # Returns a hash the dashboard renders: which step, headline, cta path.
  def next_step
    if !learn_complete?
      current = lesson_items.find { |i| i.status == :current }&.record || lessons.first
      { step: learn_step, progress: "#{lessons_done}/#{lessons_total} complete", cta: "Continue",
        lesson: current, thumb: current }
    elsif !assess_complete?
      current = assessment_items.find { |i| i.status == :current }&.record || assessments.first
      { step: assess_step, progress: "#{assessments_done}/#{assessments.size} complete", cta: "Continue",
        assessment: current, thumb: lessons.first }
    elsif !complete?
      { step: meet_step, progress: "Ready to schedule", cta: "Schedule", appointment: true, thumb: lessons.first }
    else
      { step: meet_step, progress: "You're all in", cta: "View my plan", done: true, thumb: lessons.first }
    end
  end

  def percent
    total = lessons_total + assessments.size + 1
    done  = lessons_done + assessments_done + (complete? ? 1 : 0)
    total.zero? ? 0 : (done * 100.0 / total).round
  end
end
