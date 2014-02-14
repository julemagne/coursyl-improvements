class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end


end
