class Person < Neo4j::Rails::Model
  property :name, :index => :exact
  property :birth_date, :type => Date
  property :tmdb_id, :index => :exact, :unique => :true
  property :tmdb_url, :index => :exact, :unique => :true
  property :imdb_url, :index => :exact, :unique => :true
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
end
