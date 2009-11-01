#!/usr/bin/ruby
#Toggles loop
require 'common'

$mpd.repeat = ($mpd.repeat? ? false : true)

print "Location: index.rb\r\n"
print "\r\n"
