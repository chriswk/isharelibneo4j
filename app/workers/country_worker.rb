class CountryWorker
  include Sidekiq::Worker

  def perform(movie, country)
    c = Country.find_or_create_by(:iso_3166_1 => country.iso_3166_1)
    c.name = country.name
    c.save
    movie.countries << c
    movie.save
  end
end