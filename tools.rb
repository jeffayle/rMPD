#!/usr/bin/ruby
#Some tools
require 'config'

ENV['REQUEST_URI'] =~ /\?(.+)$/
tool = $1

if tool == 'shuffle'
    $mpd.shuffle
elsif tool == 'ralbum'
    all = $mpd.albums
    album = all[(rand*all.length).floor]
    songs = $mpd.find 'album', album
    #Clear playlist, then queue songs
    $mpd.clear
    songs.each do |s|
        $mpd.add s['file']
    end
    $mpd.play 0
end

print "Location: index.rb\r\n"
print "\r\n"
