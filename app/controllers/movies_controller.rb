class MoviesController < ApplicationController
  def index
    @top_movies = MovieServicer.top_movies if params[:top_rated].present?
    @search_movie = MovieServicer.find_movie(params[:search]) if params[:search].present?
  end

  def show
    if current_user
      @movie = MovieServicer.movie_detail(params[:id])
      @reviews = MovieServicer.reviews(params[:id])
      @cast = MovieServicer.cast(params[:id])
    else
      flash[:alert] = 'You must be logged in to view movies'
      redirect_to root_path
    end
  end
end
