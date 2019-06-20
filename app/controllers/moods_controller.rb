class MoodsController < ApplicationController
  def index
    @moods = Mood.all
  end

  def show
    @mood = Mood.find(params[:id]) rescue nil
    if !@mood
      flash[:errors] = ["That mood could not be found, please try another page."]
      redirect_to (request.referer || root_path)
    end
  end
end
