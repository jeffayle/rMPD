#!/usr/bin/ruby
require 'rubygems'
require 'config'
require 'erb'

print "Content-Type: text/html\r\n"
print "\r\n" #End of header

#Current playing status, for buttons
$playing = $mpd.playing?
$stopped = $mpd.stopped?
$current = ($mpd.current_song || {'pos'=>-1})['pos']
$repeat = $mpd.repeat?

#Get current playlist
$playlist = $mpd.playlist

out = ERB.new(File.read('views/index.html'))
print out.result
