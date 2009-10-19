#!/usr/bin/ruby
#Gives access to music library files over HTTP
require 'config'

ENV['REQUEST_URI'] =~ /\?(.*)$/
f = $config[:mdir] + '/' + $1.url_decode
f = File.open f, 'rb'

print "Content-Type: audio/mpeg\r\n"#TODO: Make it guess mime type
print "\r\n"

#Outputs file
while blk = f.read(4096)
    $stdout.print blk
    $stdout.flush
end

f.close
