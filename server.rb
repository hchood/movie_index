require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require 'csv'

# FEATURE 1:
# When visiting the /movies path it should list all
# of the movies sorted by title.
# Each title should be a clickable link that takes
# you to /movies/:movie_id, where :movie_id is
# replaced by the numeric ID for that movie
# (e.g. /movies/2 will take you to the page for Troll 2).

# FEATURE 2:
# When visiting the /movies/:movie_id path, it should list
# the details for the movie identified by :movie_id.
# The details should include the title, the year released,
# the synopsis, the rating, the genre, and the studio that produced it
# (leave blank if any fields are not available).

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

# {
#   id: 2,
#   title: 'Troll 2',
#   year: 1990,
#   synopsis: '',
#   rating: 0,
#   genre: 'Horror',
#   studio: 'MGM'
# }

# retrieve a movie from a CSV given movie id
def find_movie_by(filename, id)
  movie = {}

  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    if id == row[:id]
      movie = row.to_hash
      break
    end
  end

  movie
end

##########################
#         ROUTES
##########################

get '/movies' do
  @movies = read_movies_from('movies.csv')

  erb :'/movies/index'
end

get '/movies/:id' do
  @movie = find_movie_by('movies.csv', params[:id])

  erb :'/movies/show'
end











