class LessonsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_lesson_and_course, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:new, :create, :schedule, :index]
  before_action :instructor_only!, except: [:show]

  # GET
  def index
    @root_lessons = @course.lessons.roots
  end

  # GET
  def schedule
    if @course.meetings.blank?
      redirect_to meetings_path(course_id: @course.id)
    elsif @course.lessons.blank?
      redirect_to lessons_path(course_id: @course.id)
    else
      @root_lessons = @course.lessons.roots
      @meetings = @course.meetings
    end
  end

  # GET
  def new
    @lesson = Lesson.new
    @lesson.course_id = @course.id
    @lesson.parent_lesson = Lesson.find(params[:parent_lesson_id]) if params[:parent_lesson_id]

    @lesson.readings.build
  end

  # GET
  def edit
    @lesson.readings.build
  end

  # POST
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lessons_path(course_id: @course.id), flash: {success: 'Lesson was successfully created.'} }
      else
        @lesson.readings.build
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to params[:redirect] || lessons_path(course_id: @course.id), flash: {success: 'Lesson was successfully updated.'} }
      else
        @lesson.readings.build
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_path(course_id: @course.id), notice: 'Lesson was successfully deleted.' }
    end
  end

  private
    def set_lesson_and_course
      @lesson = Lesson.find(params[:id])
      @course = @lesson.course
    end

    def set_course
      @course = Course.find(params[:course_id] || params[:lesson][:course_id])
    end

    def lesson_params
      params.require(:lesson).permit(:course_id, :parent_lesson_id, :name,
          :description, :outline, :lead_in_question,
          readings_attributes: [:id, :caption, :url, :order_number, :before_lesson, :_destroy])
    end
end
