class Movie < Neo4j::Rails::Model
  property :title, :year, :index => :exact
  property :tmdb_id, :index => :exact, :unique => true
  property :tmdb_url, :index => :exact, :unique => true
  property :imdb_url, :index => :exact, :unique => true
  property :imdb_id, :index => :exact, :unique => true
  property :overview
  property :released, :type => Date
  has_n(:people).from(Person, :acted_in)
  has_one(:sequel)
  validates_presence_of :title
  validates_uniqueness_of :tmdb_id, :imdb_id

  def update_from_tmdb()
    tm_movie = TmdbMovie.find(:id => self.tmdb_id)
    self.map_tmdb(tm_movie)
    self.save
  end
  
  def map_tmdb(tm_movie)
    self.title = tm_movie.name
    self.tmdb_id = tm_movie.id
    self.imdb_id = tm_movie.imdb_id
    self.tmdb_url = tm_movie.url
    self.released = Date.parse(tm_movie.released)
    self.year = self.released.year
    self.overview = tm_movie.overview
    map_cast(tm_movie.cast)
  end
  
  def map_cast(cast)
    cast.each do |role|
      person = Person.find_or_create(:tmdb_id => role.id)
      person.map_movie_role(self, role)
    end
  end
  
  def find_or_create(tmdb_id)
    Movie.find(:tmdb_id => tmdb_id) || Movie.new(:tmdb_id)
  end
end
