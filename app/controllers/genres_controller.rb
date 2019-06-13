class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genres = Genre.find(params[:id])
  end
end
