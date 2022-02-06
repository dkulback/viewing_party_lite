class MovieServicer
  attr_reader :movie_client

  def initialize(_movie_client = MovieClient)
    @movie_client = MovieClient
  end

  def self.top_movies
    MovieClient.top_rated[:results].map { |data| Movie.new(data) }
  end

  def self.find_movie(movie)
    MovieClient.search_movie(movie)[:results].map { |data| Movie.new(data) }
  end

  def self.movie_detail(movie_id)
    Movie.new(MovieClient.movie_details(movie_id))
  end

  def self.reviews(movie_id)
    MovieClient.get_reviews(movie_id).map { |data| Review.new(data) }
  end

  def self.cast(movie_id)
    MovieClient.get_cast(movie_id).map { |data| CastMember.new(data) }
  end
end
