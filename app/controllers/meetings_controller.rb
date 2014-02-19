class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :instructor_only!

  # POST
  def create
    @meeting = Meeting.new(held_at: params[:held_at], course_id: params[:course_id])

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to lessons_path(course_id: params[:course_id]), flash: {success: 'Meeting was successfully created.'} }
      else
        format.html { redirect_to lessons_path(course_id: params[:course_id]), flash: {error: 'Meeting failed to save.  Try again.'} }
      end
    end
  end

  private

    def set_course
      @course = Course.find(params[:course_id])
    end

    def meeting_params
      params.require(:meeting).permit(:course_id, :held_at)
    end
end
