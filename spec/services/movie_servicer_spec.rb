require 'rails_helper'

RSpec.describe MovieServicer do
  let(:servicer) { MovieServicer }
  describe '#top_movies' do
    it 'returns a list of movies' do
      VCR.use_cassette('top_rated_movies') do
        actual = servicer.top_movies[0]
        expected = Movie
        expect(actual).to be_a(expected)
      end
    end
  end
  describe '::find_movie' do
    it 'returns a list of movies' do
      VCR.use_cassette('search_movies') do
        actual = servicer.find_movie('Shaw')[0]
        expected = Movie
        expect(actual).to be_a(expected)
      end
    end
  end
  describe '::movie_detail' do
    it 'returns a  Movie' do
      VCR.use_cassette('your_eyes_tell') do
        actual = servicer.movie_detail('730154')
        expected = Movie
        expect(actual).to be_a(expected)
      end
    end
  end
  describe '::movie_detail' do
    it 'returns a Movie reviews' do
      VCR.use_cassette('cloud_atlas_reviews') do
        actual = servicer.reviews('83542')[0]
        expected = Review
        expect(actual).to be_a(expected)
      end
    end
  end
  describe '::cast' do
    it 'returns the cast of a movie' do
      VCR.use_cassette('cloud_atlas_cast') do
        actual = servicer.cast('83542')[0]
        expected = CastMember
        expect(actual).to be_a(expected)
      end
    end
  end
end
