class CourseStudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course_student
  before_action :set_course
  before_action :instructor_only!

  # DELETE
  def destroy
    @course_student.destroy
    respond_to do |format|
      if @course_student.destroyed?
        format.html { redirect_to @course, notice: 'Student successfully removed from course.' }
      else
        format.html { redirect_to @course, flash: { error: 'Student could not be removed.  He or she has already completed assignments.' } }
      end
    end
  end

  def approve
    if @course_student.update_attribute(:approved, true)
      redirect_to home_requests_path, notice: 'Student approved.'
    else
      redirect_to home_requests_path, flash: { error: 'Approval failed.' }
    end
  end

  private
    def set_course_student
      @course_student = CourseStudent.find(params[:id])
    end

    def set_course
      @course = (@course_student ? @course_student.course : Course.find(params[:course_id]))
    end

    def course_student_params
      params.require(:course_student).permit(:course_id, :student_id)
    end
end
