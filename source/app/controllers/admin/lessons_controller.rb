class Admin::LessonsController < Admin::BaseController
  def index
    @lessons = Lesson.ordered.includes(:step)
  end

  def edit
    @lesson = Lesson.find_by!(slug: params[:id])
  end

  def update
    @lesson = Lesson.find_by!(slug: params[:id])
    if @lesson.update(lesson_params)
      redirect_to admin_lessons_path, notice: "Saved #{@lesson.title}."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:title, :description, :kind, :vimeo_id, :vimeo_hash, :body, :speaker_notes, :published, :position, :thumbnail)
  end
end
