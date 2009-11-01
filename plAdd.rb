#!/usr/bin/ruby
#Adds specified song to the playlist
require 'common'

ENV['REQUEST_URI'] =~ /\?(.+)$/
file = $1.url_decode

dir = file.sub(/\/[^\/]+$/, '').url_encode

$mpd.add file

print "Location: browse.rb?#{dir}\r\n"
print "\r\n"

