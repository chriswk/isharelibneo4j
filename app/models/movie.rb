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

  def update_from_tmdb
    puts "Updating #{self}"
    tm_movie = TmdbMovie.find(:id => self.tmdb_id)
    self.map_tmdb(tm_movie)
    puts "Updated to [#{self} - title: #{self.title} - tmdb_id #{self.tmdb_id}]"
    self.save
  end
  
  def map_tmdb(tm_movie)
    self.title = tm_movie.title
    self.tmdb_id = tm_movie.id
    self.imdb_id = tm_movie.imdb_id
    self.tmdb_url = tm_movie.url
    self.released = Date.parse(tm_movie.release_date) rescue self.released = Date.parse("1970-01-01")
    self.year = self.released.year
    self.overview = tm_movie.overview
    map_countries(tm_movie.production_countries)
    map_cast(tm_movie.cast)
    map_posters(tm_movie.posters)
  end

  def map_posters(posters)
    posters.each do |poster|
      puts "Creating poster entry #{poster}"
      pp = Poster.find_or_create_by(:file_path => poster.file_path)
      pp.map_tmdb(poster)
      pp.save
      self.posters << pp unless self.posters.find(pp)
    end
  end
  def map_cast(cast)
    cast.each do |role|
      person = Person.find_or_create_by(:tmdb_id => role.id)
      person.map_movie_role(self, role)
      puts "Found person [#{person} - #{person.tmdb_id} - #{person.name}]"
    end
  end

  def map_countries(countries)
    countries.each do |country|
      c = Country.find_or_create_by(:iso_3166_1 => country.iso_3166_1)
      c.name = country.name
      c.save
      self.countries << c unless self.countries.find(c)
    end
  end

  def find_tmdb_id
    @pf = TmdbMovie.find(:title => self.title, :year => self.year)
  end
  
end
