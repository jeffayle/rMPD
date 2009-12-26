#!/usr/bin/ruby
#Tool to clear current playlist
require '../common'

$mpd.stop
$mpd.clear

print "Location: ../\r\n"
print "\r\n"
