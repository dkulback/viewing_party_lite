class MoviePartyServicer
  def initialize(params)
    @movie = params[:movie]
    @invites = params[:invites]
    @party_date = params[:party_date]
    @party_time = params[:party_time]
    @user_id = params[:user_id]
    @duration = params[:duration]
  end

  def create_party
    party = Party.create(date: @party_date,
                         start_time: @party_time,
                         duration: @duration,
                         movie: @movie.title,
                         host: @user_id,
                         movie_id: @movie.id)
    UserParty.create(party_id: party.id, user_id: @user_id)
    if @invites
      @invites.each do |invite|
        UserParty.create(party_id: party.id, user_id: invite.to_i) unless invite.nil?
      end
    end
  end
end
