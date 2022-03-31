class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  def index
    @genre = Genre.new
    @genre = Genre.all
  end

  def create
    Genre.create(genre_params)
    redirect_back(fallback_location:root_path)
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      redirect_to admin_genres_path
    else
      redirect_to request.referer
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
