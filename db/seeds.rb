[55751, 524, 56825, 976, 1813, 1892].each do |person_id|
  p = Person.find_or_create_by(:tmdb_id => person_id)
  p.update_from_tmdb
end
