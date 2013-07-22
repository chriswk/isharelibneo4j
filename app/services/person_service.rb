class PersonService
  def self.map_movie_role(movie, role)
      puts "Mapping movie role in [#{movie} with id #{movie.tmdb_id} and title #{movie.title} - #{role.name}]
          and character name [#{role.character}]"
      tmdbCast = TmdbCast.find(:id => role.id)
      p = map_from_tmdb(tmdbCast)
      if !p.acted_in.find(movie)
        curRole = p.acted_in_rels.connect(movie, {:title => role.name})
        curRole.character = role.character
        curRole.save
      end
      p.save
  end

  def self.map_from_tmdb(cast)
    p = Person.find_or_create_by(:tmdb_id => cast.id)
    p.name = cast.name
    p.birth_date = Date.parse(cast.birthday) rescue p.birth_date = Date.parse("1970-01-01")
    p.biography = cast.biography
    p.save
    p
  end

  def self.update_from_tmdb(tmdbId)
    map_from_tmdb(TmdbCast.find(:id => tmdbId))
  end

end