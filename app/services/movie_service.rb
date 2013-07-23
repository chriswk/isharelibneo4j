class MovieService
  def self.update_from_tmdb(*ids)
    ids.each do |tmdb_id|
      movie = Movie.find_or_create_by(:tmdb_id => tmdb_id)
      tm_movie = TmdbMovie.find(:id => movie.tmdb_id)
      puts "Updating #{movie}"
      movie.map_tmdb(tm_movie)
      movie.save
      puts "Updated to [#{movie} - title: #{movie.title} - tmdb_id #{movie.tmdb_id}]"
      map_genres(movie, tm_movie.genres)
      map_countries(movie, tm_movie.production_countries)
      map_cast(movie, tm_movie.cast)
      map_posters(movie, tm_movie.posters)
    end
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

  def self.map_genres(movie, genres)
    genres.each do |genre|
      g = Genre.find_or_create_by(:tmdb_id => genre.id)
      g.name = genre.name
      g.save
      movie.genres << g unless movie.genres.find(g)
    end
  end
end