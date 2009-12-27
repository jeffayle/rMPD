#!/usr/bin/ruby
#Tools to manage playlists
require 'common'
require 'erb'

print "Content-Type: text/html\r\n"
print "\r\n"

$playlists = $mpd.playlists

out = ERB.new(File.read('views/playlist.html'))
print out.result
