require 'rails_helper'

RSpec.describe Movie do
  describe 'initialize' do
    it 'exists' do
      movie = Movie.new({ title: 'title',
                          vote_average: 8.8,
                          runtime: 109,
                          genres: %w[horror comedy],
                          id: 82_732,
                          poster_path: '/poster_pathaddres.jpg' })
      actual = movie
      expected = Movie
      expect(actual).to be_a(expected)
    end
    describe '#attributes' do
      it 'has a title' do
        movie = Movie.new({ title: 'title',
                            vote_average: 8.8,
                            runtime: 109,
                            genres: %w[horror comedy],
                            id: 82_732,
                            poster_path: '/poster_pathaddres.jpg' })
        actual = movie.title
        expected = 'title'

        expect(actual).to eq(expected)
      end
      it 'has a vote_average' do
        movie = Movie.new({ title: 'title',
                            vote_average: 8.8,
                            runtime: 109,
                            genres: %w[horror comedy],
                            id: 82_732,
                            poster_path: '/poster_pathaddres.jpg' })
        actual = movie.vote_avg
        expected = 8.8

        expect(actual).to eq(expected)
      end
      it 'has a runtime' do
        movie = Movie.new({ title: 'title', vote_average: 8.8,
                            runtime: 109,
                            genres: %w[horror comedy],
                            id: 82_732,
                            poster_path: '/poster_pathaddres.jpg' })
        actual = movie.runtime
        expected = 109

        expect(actual).to eq(expected)
      end
      it 'has a genres' do
        movie = Movie.new({ title: 'title',
                            vote_average: 8.8,
                            runtime: 109,
                            genres: 'string',
                            id: 82_732,
                            poster_path_path: '/poster_pathaddres.jpg' })
        actual = movie.genre
        expected = 'string'
        expect(actual).to eq(expected)
      end
      it 'has a summary' do
        movie = Movie.new({ title: 'title', vote_average: 8.8, runtime: 109, genres: %w[horror comedy], id: 82_732,
                            poster_path: '/poster_pathaddres.jpg',
                            overview: 'really good' })
        actual = movie.summary
        expected = 'really good'

        expect(actual).to eq(expected)
      end
      it 'has a id' do
        movie = Movie.new({ title: 'title',
                            vote_average: 8.8,
                            runtime: 109,
                            genres: %w[horror comedy],
                            id: 82_732,
                            poster_path: '/poster_pathaddres.jpg' })
        actual = movie.id
        expected = 82_732

        expect(actual).to eq(expected)
      end
      it 'has a poster_path' do
        movie = Movie.new({ title: 'title',
                            vote_average: 8.8,
                            runtime: 109,
                            genres: %w[horror comedy],
                            id: 82_732,
                            poster_path: '/poster_pathaddres.jpg' })
        actual = movie.poster
        expected = '/poster_pathaddres.jpg'

        expect(actual).to eq(expected)
      end
    end
  end
end
