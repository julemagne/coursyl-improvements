class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses/new
  def new
    @course = Course.new
    @course.course_instructors.build(instructor_id: current_user.id, primary: true)
  end

  # GET /courses/1
  def show
  end

  # POST /courses
  def create
    @course = Course.new(params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, flash: {success: 'Course was successfully created.'} }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

end
