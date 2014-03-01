class MeetingsController < ApplicationController
  before_action :authenticate_user!, except: [:lead_in_question, :media]
  before_action :set_meeting, only: [:edit, :update, :destroy, :lead_in_question, :outline, :media]
  before_action :set_course
  before_action :instructor_only!, except: [:lead_in_question, :media]

  def lead_in_question
  end

  def outline
  end

  def media
  end

  # GET
  def index
    @meetings = @course.meetings
  end


  # GET
  def edit
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


  # POST
  def create_many
    start_date   = params[:start_date].to_date
    end_date     = params[:end_date].to_date
    days_of_week = params[:day].map {|k, v| v.to_i}

    respond_to do |format|
      if @course.create_series_of_meetings(start_date, end_date, params[:time_of_day], days_of_week)
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {success: 'Meetings were successfully created.'} }
      else
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {error: 'Meetings failed to save.  Try again.'} }
      end
    end
  end


  # PATCH/PUT
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meetings_path(course_id: @course.id), flash: {success: 'Meeting was successfully updated.'} }
      else
        format.html { render action: 'edit' }
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
      params.require(:meeting).permit(:course_id, :held_at, :video_url)
    end
end
