class UsersMoviesPartiesController < ApplicationController
  before_action :current_user, only: %i[new create]
  def new
    @user = current_user
    @movie = MovieServicer.movie_detail(params[:movie_id])
    @users = User.all.where.not(id: @user.id)
  end

  def create
    @movie = MovieServicer.movie_detail(params[:movie_id])
    if @movie.runtime.to_i > params[:duration].to_i
      flash[:duration] = "Duration can't be shorter than movies runtime."
      redirect_to new_movie_party_path
    elsif party = Party.create(date: party_date, start_time: party_time, duration: params[:duration],
                               movie: @movie.title, host: params[:user_id], movie_id: params[:movie_id])
      UserParty.create(party_id: party.id, user_id: params[:user_id])
      if params[:invites].present?
        params[:invites].each do |invite|
          UserParty.create(party_id: party.id, user_id: invite.to_i) unless invite.nil?
        end
      end
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
