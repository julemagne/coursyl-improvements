class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only!, only: [:index, :destroy, :approve_as_instructor, :reject_as_instructor]
  before_action :instructor_only!, only: [:change_password]
  before_action :set_user, only: [:edit, :update, :destroy, :approve_as_instructor, :reject_as_instructor, :change_password]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
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

  # GET /users/new_student
  def new_student
    @user = User.new
    @user.email = params[:email]
    @course = Course.find(params[:course_id])
  end

  # POST /users/create_student
  def create_student
    @user = User.new(user_params)
    @user.school = current_user.school
    params[:email] = @user.email

    @course = Course.find(params[:course_id])
    @user.course_students.build(course: @course, student: @user, approved: true)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @course, flash: {success: 'Student was successfully created and added to this course.'} }
      else
        format.html { render action: 'new_student' }
      end
    end
  end

  # GET/PATCH /users/change_password
  def change_password
    if request.patch? && @user.update(user_params)
      redirect_to home_index_path, flash: {success: "Password for #{@user.full_name} has been changed."}
    else
      render action: 'change_password'
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to (current_user.admin ? users_url : home_index_path), flash: {success: 'User record was successfully updated.'} }
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
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :title, :first_name, :middle_name, :last_name, :phone, :office, :office_hours, :photo_url, :description, :admin, :wants_to_be_instructor, :instructor, :school_id, :password, :password_confirmation)
    end
end
