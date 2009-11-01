#!/usr/bin/ruby
#Plays all songs in specified folder
require '../common'

ENV['REQUEST_URI'] =~ /\?(.*)$/
dir = $1.url_decode

$mpd.clear
$mpd.add dir
$mpd.play 0

print "Location: ../browse.rb?#{dir.url_encode}\r\n"
print "\r\n"
