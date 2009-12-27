#!/usr/bin/ruby
#Adds specified song to the playlist
require 'common'

ENV['REQUEST_URI'] =~ /\?(.+)$/
file = $1.url_decode

dir = file.sub(/\/[^\/]+$/, '').url_encode

$mpd.add file

#Go back to previous page
back = ENV['HTTP_REFERER']

print "Location: #{back}\r\n"
print "\r\n"

