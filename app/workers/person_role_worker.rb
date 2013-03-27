class PersonRoleWorker
  include Sidekiq::Worker

  def perform(movie, role)
    person = Person.find_or_create_by(:tmdb_id => role.id)
    person.map_movie_role(movie, role)
    person.save
  end
end