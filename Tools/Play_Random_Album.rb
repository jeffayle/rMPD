#!/usr/bin/ruby
#Clears the current playlist, then plays a random album
require '../common'

#Get list of upcoming albums
nexts = nil
if File.file? '../State/Play_Random_Album'
    nexts = File.read('../State/Play_Random_Album').split("\n")
    nexts = nil if nexts.length == 0
end
unless nexts
    all = $mpd.albums
    nexts = Array.new
    25.times do
       n = rand(all.length)
       nexts << all.delete_at(n)
    end
end

album = nexts.delete_at(0)
songs = $mpd.find 'album', album

#Writes out new list of upcoming albums
f = File.open '../State/Play_Random_Album', 'w'
f.puts nexts
f.flush
f.close

#Clears the playlist, then queues those new songs
$mpd.clear
songs.each do |s|
    $mpd.add s['file']
end
$mpd.play 0

print "Location: ../\r\n"
print "\r\n"
