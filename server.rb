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


##########################
#         ROUTES
##########################

get '/movies' do
  @movies = read_movies_from('movies.csv')

  erb :'/movies/index'
end











