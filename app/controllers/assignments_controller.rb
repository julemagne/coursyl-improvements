class AssignmentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_assignment_and_course, only: [:show, :edit, :update, :destroy, :turn_in, :grade]
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
    #Build new question so that more can be added w/o JS.
    @assignment.assignment_questions.build
  end

  # POST
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to edit_assignment_path(@assignment), notice: 'Assignment was successfully created.' }
        format.json { render action: 'edit', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to edit_assignment_path(@assignment), notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  # POST
  def turn_in
    final = (params[:commit]=="Submit Final Answers")
    if @assignment.turn_in(params[:questions], current_user, final)
      if final
        flash[:notice] = "You have turned in #{@assignment.name}."
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
    if current_user.teaching?(@assignment.course)
      if request.post?
        @assignment.maximum_grade = params[:maximum_grade]
        @assignment.grades_released = (params[:grades_released].blank? ? false : true)
        @assignment.save!
        params[:grades].each do |k, v|
          AssignmentQuestionGrade.find(k).update_attributes!(v)
        end
        flash[:notice] = "You have successfully saved these grades."
      end
    else
      flash[:error] = "You are not allowed to grade #{@assignment.name}."
      redirect_to @assignment.course
    end
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
