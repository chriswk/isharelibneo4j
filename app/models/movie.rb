class Movie < Neo4j::Rails::Model
  property :title, :year, :index => :exact
  property :tmdb_id, :index => :exact, :unique => true
  property :tmdb_url, :index => :exact, :unique => true
  property :imdb_url, :index => :exact, :unique => true
  property :imdb_id, :index => :exact, :unique => true
  property :overview
  property :released, :type => Date
  property :updated_at, :type => Date
  property :created_at, :type => Date
  has_n(:countries).to(Country)
  has_n(:people).from(Person, :acted_in)
  has_one(:sequel)
  has_n(:posters).to(Poster)
  validates_presence_of :title

  validates_uniqueness_of :tmdb_id, :imdb_id


  def find_tmdb_id
    @pf = TmdbMovie.find(:title => self.title, :year => self.year)
  end

  def map_tmdb(tm_movie)
    self.title = tm_movie.title
    self.tmdb_id = tm_movie.id
    self.imdb_id = tm_movie.imdb_id
    self.tmdb_url = tm_movie.url
    self.released = Date.parse(tm_movie.release_date) rescue self.released = Date.parse("1970-01-01")
    self.year = self.released.year
    self.overview = tm_movie.overview
  end

end

