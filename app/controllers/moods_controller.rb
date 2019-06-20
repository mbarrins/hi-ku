class MoodsController < ApplicationController
  def index
    @page_title = "All Moods"
    @moods = Mood.all
  end

  def show
    @mood = Mood.find(params[:id])
    @page_title = @mood.name
  end
end
