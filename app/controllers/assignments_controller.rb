class AssignmentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_assignment_and_course, only: [:show, :edit, :update, :destroy, :turn_in, :grade, :view_grades]
  before_action :set_course, only: [:new, :create]
  before_action :instructor_only!, except: [:show, :turn_in]

  # GET
  def show
  end

  # GET
  def new
    @assignment = Assignment.new
    @assignment.course_id = @course.id

    #Build new question so that more can be added w/o JS.
    @assignment.assignment_questions.build
  end

  # GET
  def edit
    @assignment.assignment_questions.build
  end

  # POST
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to course_path(@course), flash: {success: 'Assignment was successfully created.'} }
      else
        @assignment.assignment_questions.build
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to course_path(@course), flash: {success: 'Assignment was successfully updated.'} }
      else
        @assignment.assignment_questions.build
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
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
      if params[:grades].blank?
        flash[:notice] = "You have saved changes to this assignment, but no grades were recorded."
      else
        params[:grades].each do |k, v|
          AssignmentQuestionGrade.find(k).update_attributes!(v)
        end
        flash[:success] = "You have successfully saved these grades."
      end
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
          :fraction_of_grade, :maximum_grade, :students_can_submit,
          assignment_questions_attributes: [:id, :question, :points, :order_number, :_destroy])
    end
end
