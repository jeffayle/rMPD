#!/usr/bin/ruby
require 'config'

ENV['REQUEST_URI'] =~ /\?(\d+)$/
item = $1.to_i
$mpd.delete item

print "Location: index.rb\r\n"
print "\r\n"
