class UsersMoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @top_movies = TopRated.new.movies if params[:top_rated].present?
  end

  def create
    if params[:search].present?
      @search_movie = SearchMovie.new.search(params[:search])
      render 'index'
    end
  end

<<<<<<< HEAD
  def show; end
=======
  def show
    @user = User.find(params[:user_id])
    @movie = SingleMovie.new.search(params[:id])
    @reviews = FindReview.new.search(params[:id])
    render 'users/movies/show'
  end
>>>>>>> 64635096b3cd454a46c2ad45037361d57de39ebf
end
