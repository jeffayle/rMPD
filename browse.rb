#!/usr/bin/ruby
#Browse directories and music files
require 'common'
require 'erb'

ENV['REQUEST_URI'] =~ /\?(.+)$/
$dir = ($1 || '').url_decode

#Directories
$listing = $mpd.directories($dir, false).sort_nocase
#Attach .parent method
def $dir.parent()
    p = self.dup
    if p =~ /\//
        p.sub /\/[^\/]+$/, ''
    else
        ''
    end
end

#Files listing
$files = $mpd.songs $dir, false

#Tools
$tools = Dir.entries('DirectoryTools/').select{|d| d[0,1] != '.'}.sort_nocase

print "Content-Type: text/html\r\n"
print "\r\n"

out = ERB.new(File.read('views/browse.html'))
print out.result
