class MeetingLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting_lesson, only: [:destroy, :destroy_and_shift]
  before_action :set_course
  before_action :instructor_only!

  # POST
  def create
    @meeting_lesson = MeetingLesson.new(meeting_id: params[:meeting_id], lesson_id: params[:lesson_id])

    respond_to do |format|
      if @meeting_lesson.save
        unless params[:commit]=="Schedule Lesson"
          @meeting_lesson.shift_forward
        end
        format.html { redirect_to schedule_lessons_path(course_id: @course.id), flash: {success: 'Scheduling was successful.'} }
      else
        format.html { redirect_to schedule_lessons_path(course_id: @course.id), flash: {error: 'Scheduling failed to save.  Try again.'} }
      end
    end
  end


  # DELETE
  def destroy
    @meeting_lesson.destroy
    respond_to do |format|
      format.html { redirect_to schedule_lessons_path(course_id: @course), notice: 'Lesson was successfully removed.' }
    end
  end


  # DELETE
  def destroy_and_shift
    @meeting_lesson.destroy
    @meeting_lesson.shift_back
    respond_to do |format|
      format.html { redirect_to schedule_lessons_path(course_id: @course), notice: 'Lesson was successfully removed.' }
    end
  end

  private
    def set_meeting_lesson
      @meeting_lesson = MeetingLesson.find(params[:id])
    end

    def set_course
      @course = (@meeting_lesson ? @meeting_lesson.course : Meeting.find(params[:meeting_id]).course)
    end

    def meeting_params
      params.require(:meeting_lesson).permit(:meeting_id, :lesson_id)
    end
end

