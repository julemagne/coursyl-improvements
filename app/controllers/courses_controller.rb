class CoursesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @course = Course.find(params[:id])
  end
end
