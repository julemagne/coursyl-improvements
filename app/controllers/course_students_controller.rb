class CourseStudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_student
  before_action :set_course
  before_action :set_student
  before_action :instructor_only!

  # DELETE
  def destroy
    @course_student.destroy
    respond_to do |format|
      if @course_student.destroyed?
        format.html { redirect_to :back, notice: 'Student successfully removed from course.' }
      else
        format.html { redirect_to :back, flash: { error: 'Student could not be removed.  He or she has already completed assignments.' } }
      end
    end
  end

  # PATCH
  def approve
    if @course_student.update_attribute(:approved, true)
      redirect_to home_requests_path, notice: 'Student approved.'
    else
      redirect_to home_requests_path, flash: { error: 'Approval failed.' }
    end
  end

  # GET/PATCH
  def change_email
    if @student.admin? || @student.instructor?
      redirect_to @course, flash: {error: "You may not change the email address for an instructor or an admin."}
    elsif request.patch?
      if found_user = User.find_by_email(params[:user][:email])
        @course_student.student = found_user
        @course_student.save!
        redirect_to @course, flash: {success: "Enrollment has been moved to a different existing user."}
      elsif @student.update_attribute(:email, params[:user][:email])
        redirect_to @course, flash: {success: "Email address has been changed."}
      end
    end
  end

  # GET/PATCH
  def change_code
    if request.patch? && @student.update_attributes(code: params[:user][:code])
      redirect_to @course, flash: {success: "Code for #{@student.full_name} has been changed."}
    end
  end

  # GET/PATCH
  def change_password
    if @student.admin? || @student.instructor?
      redirect_to @course, flash: {error: "You may not change the password for an instructor or an admin."}
    elsif request.patch? && @student.update_attributes(password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation])
      redirect_to @course, flash: {success: "Password for #{@student.full_name} has been changed."}
    end
  end

  private
    def set_course_student
      @course_student = CourseStudent.find(params[:id])
    end

    def set_course
      @course = @course_student.course
    end

    def set_student
      @student = @course_student.student
    end

    def course_student_params
      params.require(:course_student).permit(:course_id, :student_id)
    end
end
