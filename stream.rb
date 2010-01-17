#!/usr/bin/ruby
#Gives access to music library files over HTTP
require 'rubygems'
require 'common'
require 'mime/types'

ENV['REQUEST_URI'] =~ /\?(.*)$/
f = $config[:mdir] + '/' + $1.url_decode

if f =~ /\/\.\.\//
    exit #If url contains /../, exit to not expose filesystem
end

mime = MIME::Types.type_for(f)[0].content_type
f = File.open f, 'rb'

print "Content-Type: #{mime}\r\n"
print "\r\n"

#Outputs file
while blk = f.read(4096)
    $stdout.print blk
    $stdout.flush
end

f.close
