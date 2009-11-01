#!/usr/bin/ruby
#Gives the user an M3U playlist with remote URLs for streaming
require '../common'

ENV['REQUEST_URI'] =~ /\?(.*)$/
dir = $1.url_decode

#Get files
files = $mpd.files dir

print "Content-Type: audio/x-mpegurl\r\n"
print "\r\n"

puts "# Directory: #{dir}"
files.each do |s|
     puts $config[:httpAddr] + '/stream.rb?' + s.url_encode
end

##TODO: Add extra metadata
