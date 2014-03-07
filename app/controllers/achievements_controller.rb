class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_achievement_and_course, except: [:new, :create, :award]
  before_action :set_course, only: [:new, :create, :award]
  before_action :instructor_only!

  # GET
  def new
    @achievement = Achievement.new
    @achievement.course_id = @course.id
  end

  # GET
  def edit
  end

  # POST
  def create
    @achievement = Achievement.new(achievement_params)

    respond_to do |format|
      if @achievement.save
        format.html { redirect_to course_path(@course), flash: {success: 'Achievement was successfully created.'} }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @achievement.update(achievement_params)
        format.html { redirect_to course_path(@course), flash: {success: 'Achievement was successfully updated.'} }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # GET OR POST
  def award
    if request.post? && params[:shown].present?
      Achievement.transaction do
        params[:shown].each do |cs_id, a_hash|
          a_hash.each do |a_id, value|
            awarded = (params[:aas].present? && params[:aas][cs_id].present? && params[:aas][cs_id][a_id].present?)
            aa = AwardedAchievement.where(course_student_id: cs_id, achievement_id: a_id).first_or_create!
            aa.update_attribute(:awarded, awarded)
          end
        end
        flash.now[:success] = "You have successfully awarded these achievements."
      end
    end
  end

  private
    def set_achievement_and_course
      @achievement = Achievement.find(params[:id])
      @course = @achievement.course
    end

    def set_course
      @course = Course.find(params[:course_id] || params[:achievement][:course_id])
    end

    def achievement_params
      params.require(:achievement).permit(:course_id, :name, :description, :points,
          :category, :icon, :icon_color, :badge_color)
    end
end
