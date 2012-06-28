class Person < Neo4j::Rails::Model
  property :name, :index => :exact
  property :birth_date, :type => Date
  property :tmdb_id, :index => :exact, :unique => :true
  has_n(:acted_in).to(Movie).relationship(Role)

  def age
    if(birth_date)
      now = Time.now.utc.to_date
      age = now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
    else
      age = 0
    end
    age
  end
  
  def map_movie_role(movie, role)
    map_from_tmdb(TmdbCast.find(:id => role.id)) unless self.name && self.birth_date
    self.acted_in.create(:title => movie.title, :character => role.character)
    self.save
  end
  
  def map_from_tmdb(tmdb)
    self.name = tmdb.name
    self.birth_date = Date.parse(tmdb.birthday) rescue self.birth_date = Date.parse("1970-01-01")
    self.tmdb_id = tmdb.id unless self.tmdb_id
  end
  
  def update_from_tmdb
    tmdbPerson = TmdbCast.find(:id => self.tmdb_id)
    map_from_tmdb(tmdbPerson)
    tmdbPerson.filmography.each do |film|
      curMovie = Movie.find_or_create_by(:tmdb_id => film.id)
      curMovie.update_from_tmdb
      role = self.acted_in.create(:title => film.name, :character => film.character) unless self.acted_in.find(curMovie)
    end
    self.save
  end
end
