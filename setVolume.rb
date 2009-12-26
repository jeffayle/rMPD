#!/usr/bin/ruby
#Sets the volume from query string
require 'common'

ENV['REQUEST_URI'] =~ /\?(\d+)$/
vol = $1.to_i

$mpd.volume = vol

print "Location: index.rb\r\n"
print "\r\n"
