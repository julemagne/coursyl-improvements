class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_course, only: [:show, :edit, :update, :destroy, :policies, :grade_thresholds, :enroll, :register,
                                    :copy, :time_cards, :set_feedback_questions]
  before_action :instructor_only!, only: [:new, :create, :edit, :update, :policies, :grade_thresholds, :enroll, :copy,
                                    :time_cards, :set_feedback_questions]
  before_action :admin_only!, only: [:destroy]

  # GET /courses/new
  def new
    @course = Course.new
    @course.course_instructors.build(course: @course, instructor: current_user, primary: true)
    @course.course_instructors.build
  end

  # GET /courses/new_options
  def new_options
  end

  # GET/POST
  def copy
    if request.post?
      if (new_course = @course.copy(current_user, Term.find(params[:term_id]), params[:include_objects]))
        redirect_to new_course, flash: {success: 'Course was successfully copied.'}
      else
        redirect_to @course, flash: {error: 'Course could not be copied.  Please contact technical support.'}
      end
    end
  end

  # GET /courses/1
  def show
    unless @course.public || (current_user && current_user.participating?(@course))
      redirect_to home_index_path, flash: {error: 'You do not have permission to view this course.'}
    end
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

  #POST
  def enroll
    student = User.find_by_email(params[:email])
    if student
      if student.enrolled? @course
        redirect_to @course, flash: {error: "Student is already enrolled in this class."}
      else
        @course.course_students.build(student: student, approved: true)
        @course.save!
        redirect_to @course, flash: {success: "Student has been successfully added."}
      end
    else
      redirect_to new_student_user_url(course_id: @course.id, email: params[:email]),
        notice: "E-mail address not found.  Please create a new student."
    end
  end

  #POST
  def register
    student = User.find(params[:student_id])
    if student.enrolled? @course
      redirect_to @course, flash: {error: "You are already enrolled in this class."}
    else
      @course.course_students.build(student: student, approved: false)
      @course.save!
      redirect_to @course, flash: {success: "You have been enrolled in this class, and the instructor has been notified."}
    end
  end

  #GET/POST
  def time_cards
    if request.post?
      if (student = User.where(code: params[:code]).first) && student.enrolled?(@course)
        CourseStudent.where(course: @course, student: student).first.check_in_or_out
      else
        flash[:error] = "This code does not belong to any of the students in this course.  Please try again."
      end
    end
  end

  # GET/PATCH
  def set_feedback_questions
    if request.patch?
      if @course.update(course_params)
        redirect_to @course, flash: {success: 'Feedback questions were successfully updated.'}
      else
        @course.feedback_questions.build
      end
    else
      @course.feedback_questions.build
    end
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:term_id, :course_code, :name, :period,
          :color, :description, :public, :grading_method,
          :use_daily_questions, :use_time_cards, :use_reveal_slides, :use_meeting_video, :use_course_feedback,
          course_instructors_attributes: [:id, :primary, :instructor_id, :_destroy],
          policies_attributes: [:id, :name, :order_number, :description, :_destroy],
          grade_thresholds_attributes: [:id, :grade, :letter, :_destroy],
          feedback_questions_attributes: [:id, :question, :order_number, :_destroy])
    end

end
