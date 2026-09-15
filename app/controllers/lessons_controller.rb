class LessonsController < ApplicationController
  before_action :set_lesson
  before_action :require_unlocked

  def show
    @index    = pathway.lessons.index { |l| l.id == @lesson.id } + 1
    @total    = pathway.lessons_total
    @previous = pathway.previous_lesson(@lesson)
    @next     = pathway.next_lesson_after(@lesson)
    @complete = current_user.completed?(@lesson)
  end

  # POST /lessons/:slug/complete — called by the Vimeo "ended" event (video) or the Next button (text).
  def complete
    LessonCompletion.find_or_create_by!(user: current_user, lesson: @lesson)
    pathway.reload_if_possible
    next_lesson = pathway.next_lesson_after(@lesson)
    respond_to do |format|
      format.json { render json: { ok: true, next_url: next_lesson ? lesson_path(next_lesson) : my_progress_path } }
      format.html { redirect_to next_lesson ? lesson_path(next_lesson) : my_progress_path, status: :see_other }
    end
  end

  private

  def set_lesson
    @lesson = Lesson.published.find_by!(slug: params[:id])
  end

  def require_unlocked
    return if current_user.admin?
    return if pathway.lesson_unlocked?(@lesson)
    redirect_to my_progress_path, alert: "Finish the previous lessons to unlock this one."
  end
end
