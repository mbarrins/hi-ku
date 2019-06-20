class GenresController < ApplicationController
  def index
    @page_title = "All Genres"
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id]) rescue nil
    if !@genre
      flash[:errors] = ["That genre could not be found, please try another page."]
      redirect_to (request.referer || root_path)
    else
      @page_title = @genre.name
    end
  end
end
