class Person < Neo4j::Rails::Model
  property :name, :index => :exact
  property :birth_date, :type => Date
  property :tmdb_id, :index => :exact, :unique => :true
  property :created_at, :type => Date
  property :updated_at, :type => Date
  property :biography
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
    puts "Mapping movie role in [#{movie} with id #{movie.tmdb_id} and title #{movie.title} - #{role.name}] 
          and character name [#{role.character}]"
    map_from_tmdb(TmdbCast.find(:id => role.id))
    if !self.acted_in.find(movie)
      curRole = self.acted_in_rels.connect(movie, {:title => role.name})
      curRole.character = role.character
      curRole.save
    end
    self.save
  end
  
  def map_from_tmdb(tmdb)
    self.name = tmdb.name
    self.birth_date = Date.parse(tmdb.birthday) rescue self.birth_date = Date.parse("1970-01-01")
    self.biography = tmdb.biography
    self.tmdb_id = tmdb.id unless self.tmdb_id
  end
  
  def update_from_tmdb
    tmdbPerson = TmdbCast.find(:id => self.tmdb_id)
    map_from_tmdb(tmdbPerson)
    puts "Person now [#{self} | tmdb_id : #{self.tmdb_id} | name: #{self.name}]"
    tmdbPerson.filmography.each do |film|
      curMovie = Movie.find_or_create_by(:tmdb_id => film.id)
      puts "Found movie [#{curMovie} - #{curMovie.tmdb_id} - #{curMovie.title}]"
      curMovie.update_from_tmdb
    end
    self.save
  end
end
