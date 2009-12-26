#!/usr/bin/ruby
#Adds all songs in the folder to the end of the playlist
require '../common'

ENV['REQUEST_URI'] =~ /\?(.*)$/
dir = $1.url_decode

$mpd.add dir

print "Location: ../browse.rb?#{dir.url_encode}\r\n"
print "\r\n"
