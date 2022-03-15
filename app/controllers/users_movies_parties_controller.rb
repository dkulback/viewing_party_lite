class UsersMoviesPartiesController < ApplicationController
  before_action :current_user, only: %i[new create]
  def new
    @user = current_user
    @movie = MovieServicer.movie_detail(params[:movie_id])
    @users = User.all.where.not(id: @user.id)
  end

  def create
    @movie = MovieServicer.movie_detail(params[:movie_id])

    movie_party = MoviePartyServicer.new({
                                           party_date: party_date,
                                           party_time: party_time,
                                           user_id: params[:user_id],
                                           invites: params[:invites],
                                           duration: params[:duration],
                                           movie: @movie
                                         })
    if @movie.runtime.to_i > params[:duration].to_i
      flash[:duration] = "Duration can't be shorter than movies runtime."
      redirect_to new_movie_party_path
    else
      movie_party.create_party
      redirect_to dashboard_path
    end
  end

  private

  def party_date
    params['date(1i)'] + '-' + params['date(2i)'] + '-' + params['date(3i)']
  end

  def party_time
    params['time(4i)'] + ':' + params['time(5i)']
  end
end
