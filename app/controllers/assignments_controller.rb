class AssignmentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :admin_only!, only: [:index, :create, :update, :destroy]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :turn_in]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:course_id, :name, :active_at, :due_at, :fraction_of_grade)
    end
end
