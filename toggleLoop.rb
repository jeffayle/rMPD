#!/usr/bin/ruby
#Toggles loop
require 'config'

$mpd.repeat = ($mpd.repeat? ? false : true)

print "Location: index.rb\r\n"
print "\r\n"
