class UsersMoviesController < ApplicationController
  before_action :current_user
  def index
    @user = current_user
    if params[:top_rated].present?
      @top_movies = MovieServicer.top_movies
      render 'users/movies/index'
    end
  end

  def create
    @user = current_user
    if params[:search].present?
      @search_movie = MovieServicer.find_movie(params[:search])
      render 'users/movies/index'
    end
  end

  def show
    @user = current_user
    if @user
      @movie = MovieServicer.movie_detail(params[:id])
      @reviews = MovieServicer.reviews(params[:id])
      @cast = MovieServicer.cast(params[:id])
      render 'users/movies/show'
    else
      flast[:alert] = 'You must be logged in to view movies'
      redirect_to root_path
    end
  end
end
