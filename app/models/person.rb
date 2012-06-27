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
    puts tmdb.birthday
    self.birth_date = Date.parse(tmdb.birthday) rescue self.birth_date = Date.parse("1970-01-01")
    self.tmdb_id = tmdb.id
  end
  
  def find_or_create(tmdb_id)
    Person.find(:tmdb_id => tmdb_id) || Person.new(:tmdb_id => tmdb_id)
  end
end
