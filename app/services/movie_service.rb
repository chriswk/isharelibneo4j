class MovieService
  def self.update_from_tmdb(tmdb_id)
    movie = Movie.find_or_create_by(:tmdb_id => tmdb_id)
    tm_movie = TmdbMovie.find(:id => movie.tmdb_id)
    puts "Updateing #{movie}"
    movie.map_tmdb(tm_movie)
    movie.save
    puts "Updated to [#{movie} - title: #{movie.title} - tmdb_id #{movie.tmdb_id}]"
    map_countries(movie, tm_movie.production_countries)
    map_cast(movie, tm_movie.cast)
    map_posters(movie, tm_movie.posters)
  end

  def self.map_countries(movie, prod_countries)
    prod_countries.each do |country|
      CountryService.add_movie(movie, country)
    end
  end

  def self.map_cast(movie, cast)
    cast.each do |role|
      PersonService.map_movie_role(movie, role)
    end
  end

  def self.map_posters(movie, posters)
    posters.each do |poster|
      PosterService.add_poster(movie, poster)
    end
  end
end