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

# FEATURE 3:
# There a lot of movies to show on a single page. Limit the number of movies
# displayed at /movies to 20 with links to the next page of movies. To go to
# the second page, the URL should change to /movies?page=2 (the page number
# can be accessed in the params hash).

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

helpers do
  def on_last_page?(page_num, last_page_num)
    page_num < last_page_num
  end

  def on_first_page?(page_num)
    page_num == 1
  end
end

##########################
#         ROUTES
##########################

get '/movies' do
  all_movies = read_movies_from('movies.csv')

  # if params[:page]
  #   @page_num = params[:page].to_i
  # else
  #   @page_num = 1
  # end

  @page_num = params[:page] ? params[:page].to_i : 1

  @last_page_num = all_movies.count / 20 + 1

  last_index = @page_num * 20 - 1
  first_index = last_index - 19

  @movies = all_movies[first_index..last_index]

  erb :'/movies/index'
end

get '/movies/:id' do
  @movie = find_movie_by('movies.csv', params[:id])

  erb :'/movies/show'
end











