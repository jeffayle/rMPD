#!/usr/bin/ruby
#Clears the current playlist, then plays a random album
require '../config'

all = $mpd.albums
album = all[(rand*all.length).floor]
songs = $mpd.find 'album', album

#Clears the playlist, then queues those songs
$mpd.clear
songs.each do |s|
    $mpd.add s['file']
end
$mpd.play 0

print "Location: ../\r\n"
print "\r\n"
