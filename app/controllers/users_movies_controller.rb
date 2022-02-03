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

  def show; end
end
