class UsersMoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:top_rated].present?
      @top_movies = MovieServicer.top_movies
      render 'users/movies/index'
    end
  end

  def create
    @user = User.find(params[:user_id])
    if params[:search].present?
      @search_movie = MovieServicer.find_movie(params[:search])
      render 'users/movies/index'
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieServicer.movie_detail(params[:id])
    @reviews = MovieServicer.reviews(params[:id])
    @cast = MovieServicer.cast(params[:id])
    render 'users/movies/show'
  end
end
