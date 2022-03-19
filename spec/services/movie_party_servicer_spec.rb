require 'rails_helper'

RSpec.describe MoviePartyServicer, type: :servicer do
  let(:movie_party) do
    MoviePartyServicer.new(movie:
                           Movie.new(moive_id: 1,
                                     title: 'blinky the clown'),
                           party_date: '2 / 1 / 12',
                           party_time: '0',
                           user_id: 1,
                           duration: 2,
                           invites: [1, 2])
  end

  describe '#create_party' do
    it 'creates user_parties' do
      actual = movie_party.create_party.first
      expected = UserParty

      expect(actual).to be_a(expected)
    end
  end
end
