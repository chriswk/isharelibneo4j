class PersonWorker
  include SideKiq::Worker

  def perform(person)
    cast = Person.find_or_create_by(:tmdb_id => person.id)
    map_from_tmdb(cast)
  end

  def map_from_tmdb(cast)
    tmdbPerson = TmdbCast.find(:id => cast.tmdb_id)
    cast.map_from_tmdb(tmdbPerson)
    puts "Person now [#{cast} | tmdb_id : #{cast.tmdb_id} | name: #{cast.name}]"
    cast.save
  end
end