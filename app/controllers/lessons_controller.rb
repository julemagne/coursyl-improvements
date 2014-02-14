class LessonsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :lead_in_question]
  before_action :set_lesson_and_course, only: [:show, :edit, :update, :destroy, :lead_in_question, :outline]
  before_action :set_course, only: [:new, :create]
  before_action :instructor_only!, except: [:show, :lead_in_question]

  def lead_in_question
  end

  def outline
  end

  # GET
  def new
    @lesson = Lesson.new
    @lesson.course_id = @course.id

    @lesson.readings.build
  end

  # GET
  def edit
    @lesson.readings.build
  end

  # POST
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to edit_lesson_path(@lesson), flash: {success: 'Lesson was successfully created.'} }
      else
        @lesson.readings.build
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to edit_lesson_path(@lesson), flash: {success: 'Lesson was successfully updated.'} }
      else
        @lesson.readings.build
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
    end
  end

  private
    def set_lesson_and_course
      @lesson = Lesson.find(params[:id])
      @course = @lesson.course
    end

    def set_course
      @course = Course.find(params[:course_id] || params[:lesson][:course_id])
    end

    def lesson_params
      params.require(:lesson).permit(:course_id, :parent_lesson_id, :name, :held_at,
          :description, :outline, :video_url, :lead_in_question,
          readings_attributes: [:id, :caption, :url, :order_number, :_destroy])
    end
end
