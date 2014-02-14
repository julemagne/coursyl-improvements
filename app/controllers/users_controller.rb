class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only!, only: [:index, :destroy, :approve_as_instructor, :reject_as_instructor]
  before_action :set_user, only: [:edit, :update, :destroy, :approve_as_instructor, :reject_as_instructor]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, flash: {success: 'User was successfully created.'} }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, flash: {success: 'User was successfully updated.'} }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

  def approve_as_instructor
    @user.wants_to_be_instructor = false
    @user.instructor = true
    @user.save!
    redirect_to home_index_path, flash: {success: "#{@user.full_name} has been approved as an instructor."}
  end

  def reject_as_instructor
    @user.wants_to_be_instructor = false
    @user.save!
    redirect_to home_index_path, flash: {notice: "#{@user.full_name} has been rejected as an instructor."}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :title, :first_name, :middle_name, :last_name, :phone, :office, :office_hours, :photo_url, :description, :admin, :wants_to_be_instructor, :instructor, :school_id)
    end
end
