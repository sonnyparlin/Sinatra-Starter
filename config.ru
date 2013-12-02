require 'sinatra/base'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

map('/songs') { run SongController }
map('/') { run Website }
