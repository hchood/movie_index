require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require 'csv'

# When visiting the /movies path it should list all
# of the movies sorted by title.
# Each title should be a clickable link that takes
# you to /movies/:movie_id, where :movie_id is
# replaced by the numeric ID for that movie
# (e.g. /movies/2 will take you to the page for Troll 2).

##########################
#         METHODS
##########################

# [
#   {
#     id: 2,
#     title: 'Troll 2',
#     year: 1990,
#     synopsis: '',
#     rating: 0,
#     genre: 'Horror',
#     studio: 'MGM'
#   },
#   {...}
# ]

# creates an array of movie hashes from a CSV
def read_movies_from(filename)
  movies = []

  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    movies << row.to_hash
  end

  movies.sort_by { |movie| movie[:title] }
end

##########################
#         ROUTES
##########################

get '/movies' do
  @movies = read_movies_from('movies.csv')

  erb :'/movies/index'
end











