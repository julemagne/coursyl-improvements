class AssignmentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_assignment_and_course, only: [:show, :edit, :update, :destroy, :turn_in, :grade, :grade_matrix, :view_grades]
  before_action :set_course, only: [:new, :create]
  before_action :instructor_only!, except: [:show, :turn_in]

  # GET
  def show
  end

  # GET
  def new
    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
    end

    @assignment = Assignment.new
    @assignment.course_id = @course.id

    #Build new question so that more can be added w/o JS.
    @assignment.assignment_questions.build
  end

  # GET
  def edit
    if (@lesson = Lesson.linked_to_assignment(@assignment))
      params[:in_class] = @lesson.correct_in_class_assignment?(@assignment)
    end
    @assignment.assignment_questions.build
  end

  # POST
  def create
    @assignment = Assignment.new(assignment_params)

    if params[:lesson_id]
      @lesson = Lesson.find(params[:lesson_id])
      @assignment.name = @lesson.activity_name(params[:in_class])
      @assignment.active_at = @lesson.activity_active_at(params[:in_class])
      @assignment.due_at = @lesson.activity_due_at(params[:in_class])
    end

    respond_to do |format|
      Assignment.transaction do
        if @assignment.save
          if @lesson
            @lesson.send((params[:in_class] ? "in_class_assignment" : "pre_class_assignment") + "=", @assignment)
            @lesson.save!
          end
          format.html { redirect_to params[:redirect] || course_path(@course), flash: {success: 'Assignment was successfully created.'} }
        else
          @assignment.assignment_questions.build
          format.html { render action: 'new' }
        end
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to params[:redirect] || course_path(@course), flash: {success: 'Assignment was successfully updated.'} }
      else
        @assignment.assignment_questions.build
        format.html { render action: 'edit' }
      end
    end
  end

  # POST
  def turn_in
    final = (params[:commit]=="Submit Final Answers")
    if @assignment.turn_in(params[:questions], current_user, final)
      if final
        flash[:success] = "You have turned in #{@assignment.name}."
      else
        flash[:notice] = "You have saved a draft of #{@assignment.name}."
      end
    else
      flash[:error] = "You are not allowed to turn in #{@assignment.name}."
    end
    redirect_to @assignment
  end

  # GET OR POST
  def grade
    if request.post?
      @assignment.maximum_grade = params[:maximum_grade]
      @assignment.grades_released = (params[:grades_released].blank? ? false : true)
      @assignment.save!
      params[:grades].each do |k, v|
        AssignmentQuestionGrade.find(k).update_attributes!(v)
      end
      flash.now[:success] = "You have successfully saved these grades."
    end
  end

  # GET OR POST
  def grade_matrix
    if request.post?
      Assignment.transaction do
        @assignment.grades_released = (params[:grades_released].blank? ? false : true)
        @assignment.save!
        if params[:aqgs].present?
          params[:aqgs].each do |k, v|
            AssignmentQuestionGrade.find(k).update_attributes!(v)
          end
        end
        if params[:course_students].present?
          params[:course_students].each do |k, v|
            cs = CourseStudent.find(k)
            ag = AssignmentGrade.where(assignment_id: @assignment.id, course_student_id: cs.id).first_or_create
            ag.update_attributes!(v)
          end
        end
      end
      flash.now[:success] = "You have successfully saved these grades."
    end
  end

  # GET
  def view_grades
  end

  private
    def set_assignment_and_course
      @assignment = Assignment.find(params[:id])
      @course = @assignment.course
    end

    def set_course
      @course = Course.find(params[:course_id] || params[:assignment][:course_id])
    end

    def assignment_params
      params.require(:assignment).permit(:course_id, :name, :active_at, :due_at,
          :percent_of_grade, :maximum_grade, :students_can_submit,
          assignment_questions_attributes: [:id, :question, :points, :order_number, :_destroy])
    end
end
