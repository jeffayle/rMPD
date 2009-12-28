#!/usr/bin/ruby
#Moves an item up the playlist
require 'common'

which = ENV['QUERY_STRING'].to_i
$mpd.move which, which-1

print "Location: index.rb\r\n"
print "\r\n"
