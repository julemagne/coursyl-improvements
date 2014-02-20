class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meeting, only: [:update, :destroy]
  before_action :set_course
  before_action :instructor_only!

  # GET
  def index
    @meetings = @course.meetings
  end

  # POST
  def create
    @meeting = Meeting.new(held_at: params[:held_at], course_id: @course.id)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {success: 'Meeting was successfully created.'} }
      else
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {error: 'Meeting failed to save.  Try again.'} }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {success: 'Meeting was successfully updated.'} }
      else
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {error: 'Meeting failed to save.  Try again.'} }
      end
    end
  end

  # DELETE
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_path(course_id: @course.id), notice: 'Meeting was successfully deleted.' }
    end
  end

  private
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def set_course
      @course = (@meeting ? @meeting.course : Course.find(params[:course_id]))
    end

    def meeting_params
      params.require(:meeting).permit(:course_id, :held_at)
    end
end
