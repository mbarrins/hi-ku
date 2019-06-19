class GenresController < ApplicationController
  def index
    @page_title = "All Genres"
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @page_title = @genre.name
  end
end
