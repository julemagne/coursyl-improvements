class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_course, only: [:show, :edit, :update, :destroy, :policies, :grade_thresholds]
  before_action :instructor_only!, only: [:new, :create, :edit, :update, :policies, :grade_thresholds]
  before_action :admin_only!, only: [:destroy]

  # GET /courses/new
  def new
    @course = Course.new
    @course.course_instructors.build(course: @course, instructor: current_user, primary: true)
    @course.course_instructors.build
  end

  # GET /courses/1
  def show
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, flash: {success: 'Course was successfully created.'} }
      else
        @course.course_instructors.build
        format.html { render action: 'new' }
      end
    end
  end

  # GET /courses/1/edit
  def edit
    @course.course_instructors.build
  end

  # PATCH/PUT /courses/1
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, flash: {success: 'Course was successfully updated.'} }
      else
        @course.course_instructors.build
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to home_index_url }
    end
  end

  #GET/POST
  def policies
    @course.policies.build
    if request.post?
      if @course.update(course_params)
        redirect_to @course, flash: {success: 'Course policies were successfully updated.'}
      else
        @course.policies.build
        render action: 'policies'
      end
    end
  end

  #GET/POST
  def grade_thresholds
    @course.grade_thresholds.build
    if request.post?
      if @course.update(course_params)
        redirect_to @course, flash: {success: 'Course grade_thresholds were successfully updated.'}
      else
        @course.grade_thresholds.build
        render action: 'grade_thresholds'
      end
    end
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:term_id, :course_code, :name, :period,
          :color, :description,
          course_instructors_attributes: [:id, :primary, :instructor_id, :_destroy],
          policies_attributes: [:id, :name, :order_number, :description, :_destroy],
          grade_thresholds_attributes: [:id, :grade, :letter, :_destroy])
    end

end
