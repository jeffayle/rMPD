#!/usr/bin/ruby
#Updates the library starting at the current path
require '../config'

ENV['REQUEST_URI'] =~ /\?(.*)$/
dir = $1.url_decode

$mpd.update dir

print "Location: ../browse.rb?#{dir.url_encode}\r\n"
print "\r\n"
