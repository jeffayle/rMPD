#!/usr/bin/ruby
require 'common'
require 'erb'

print "Content-Type: text/html\r\n"
print "\r\n" #End of header

#Current playing status, for buttons
$playing = $mpd.playing?
$stopped = $mpd.stopped?
$current = $stopped ? -1 : $mpd.current_song['pos'].to_i
$repeat = $mpd.repeat?

#Get current playlist
$playlist = $mpd.playlist

#Get length of playlist
$total_length = $playlist.inject(0){|m,c| m+c['time'].to_i }

#Figure out how much of that is left
if $stopped
    $remaining_length = 0
else
    $remaining_length = $playlist[0...$current].inject(0){ |m, c|
        m + c['time'].to_i } + $mpd.time[0]
end

#Figure out how wide the playlist progress bar should be.
$pbPlayingWidth = 100.0 * $remaining_length / $total_length

#Figure out how much is left in current song
$time = $mpd.time
$pbSongWidth = 100.0 * $time[0] / $time[1]

#Get tools
$tools =  Dir.entries('Tools/').select{|d| d[0,1] != '.'}.sort_nocase

#Album art
$hasAlbumArt = if $stopped
    nil
else
    album_art $playlist[$current]['file']
end

out = ERB.new(File.read('views/index.html'))
print out.result
