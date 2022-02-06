require 'rails_helper'

RSpec.describe MovieClient do
  let(:movie_client) { MovieClient }
  describe '::top_rated' do
    it 'returns a list of top rated movies' do
      VCR.use_cassette('top_rated_movies') do
        top_rated = movie_client.top_rated

        expect(top_rated).to be_a(Hash)
        expect(top_rated[:results]).to be_a(Array)

        movie = top_rated[:results].first
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:id)
        expect(movie[:id]).to be_a(Integer)

        expect(movie).to have_key(:poster_path)
        expect(movie[:poster_path]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end
  describe '::search_movie' do
    it 'returns a single movie' do
      VCR.use_cassette('search_movies') do
        movie = movie_client.search_movie('Shaw')
        expect(movie).to be_a(Hash)
        expect(movie[:results]).to be_a(Array)

        movie = movie[:results].first
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:id)
        expect(movie[:id]).to be_a(Integer)

        expect(movie).to have_key(:poster_path)
        expect(movie[:poster_path]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end
  describe '::movie_details' do
    it 'returns a single movies details' do
      VCR.use_cassette('your_eyes_tell') do
        movie = movie_client.movie_details('730154')
        expect(movie).to be_a(Hash)
        expect(movie).to have_key(:title)
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key(:runtime)
        expect(movie[:runtime]).to be_a(Integer)

        expect(movie).to have_key(:id)
        expect(movie[:id]).to be_a(Integer)

        expect(movie).to have_key(:poster_path)
        expect(movie[:poster_path]).to be_a(String)

        expect(movie).to have_key(:vote_average)
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end
  describe '::get_reviews' do
    it 'returns a single movies reviews' do
      VCR.use_cassette('cloud_atlas_reviews') do
        reviews = movie_client.get_reviews('83542')
        expect(reviews).to be_a(Array)
        review = reviews.first
        expect(review).to be_a(Hash)
        expect(review).to have_key(:author)
        expect(review[:author]).to be_a(String)

        expect(review).to have_key(:author_details)
        expect(review[:author_details]).to be_a(Hash)

        expect(review).to have_key(:content)
        expect(review[:content]).to be_a(String)
      end
    end
  end
  describe '::get_cast' do
    it 'returns a single movies cast' do
      VCR.use_cassette('cloud_atlas_cast') do
        cast = movie_client.get_cast('83542')
        expect(cast).to be_a(Array)
        cast_member = cast.first
        expect(cast_member).to be_a(Hash)
        expect(cast_member).to have_key(:name)
        expect(cast_member[:name]).to be_a(String)

        expect(cast_member).to have_key(:character)
        expect(cast_member[:character]).to be_a(String)
      end
    end
  end
end
