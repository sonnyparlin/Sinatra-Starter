require 'sinatra/base'
require 'dm-core'
require 'bowtie'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

map('/songs') { run SongController }
map('/') { run Website }
map '/admin' do
  BOWTIE_AUTH = {:user => 'admin', :pass => '12345'}
  run Bowtie::Admin
end