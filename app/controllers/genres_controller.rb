class GenresController < ApplicationController
  def index
    @page_title = "All Genres"
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id]) rescue nil
    @poem_1 = @genre.poems.sample
    @poem_2 = @genre.poems.sample
    @poem_3 = @genre.poems.sample
    if !@genre
      flash[:errors] = ["That genre could not be found, please try another page."]
      redirect_to (request.referer || root_path)
    else
      @page_title = @genre.name
    end
  end
end
