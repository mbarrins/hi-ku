class MoodsController < ApplicationController
  def index
    @page_title = "All Moods"
    @moods = Mood.all
  end

  def show
    @mood = Mood.find(params[:id]) rescue nil
    @poem_1 = @mood.poems.sample
    @poem_2 = @mood.poems.sample
    @poem_3 = @mood.poems.sample
    @page_title = @mood.name
    if !@mood
      flash[:errors] = ["That mood could not be found, please try another page."]
      redirect_to (request.referer || root_path)
    end
  end

end
