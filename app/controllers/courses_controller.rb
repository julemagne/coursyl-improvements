class CoursesController < ApplicationController
  before_filter :authenticate_user!, except: :show

  def show
    @course = Course.find(params[:id])
  end
end
