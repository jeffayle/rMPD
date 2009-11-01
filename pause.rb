#!/usr/bin/ruby
#Pauses/Plays current song
#Starts playlist if stopped
require 'common'

if $mpd.stopped?
    $mpd.play 0
else
    $mpd.pause = ($mpd.paused? ? false : true)
end

print "Location: index.rb\r\n"
print "\r\n"
