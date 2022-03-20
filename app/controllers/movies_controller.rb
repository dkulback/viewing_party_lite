class MoviesController < ApplicationController
  def index
    @top_movies = MovieServicer.top_movies.paginate(page: params[:page], per_page: 10) if params[:top_rated].present?
    if params[:search].present?
      @search_movie = MovieServicer.find_movie(params[:search]).paginate(page: params[:page],
                                                                         per_page: 10)
    end
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
