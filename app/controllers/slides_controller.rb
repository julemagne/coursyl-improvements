class SlidesController < ApplicationController
  layout "slides"
  def show
    @meeting = Meeting.find(params[:meeting_id])
  end
end