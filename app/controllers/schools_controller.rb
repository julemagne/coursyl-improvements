class SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only!
  before_action :set_school, only: [:edit, :update, :destroy]

  # GET /schools
  def index
    @schools = School.all
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to schools_url, flash: {success: 'School was successfully created.'} }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /schools/1
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to schools_url, flash: {success: 'School was successfully updated.'} }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /schools/1
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name)
    end
end
