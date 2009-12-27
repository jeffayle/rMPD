#!/usr/bin/ruby
#Searches for files in the database
require 'common'
require 'erb'

print "Content-Type: text/html\r\n"
print "\r\n"

params = url_params ENV['REQUEST_URI']
$term = (params['search'] or '')
$type = params['type']

$type = 'title ' unless ['title','artist','album','filename'].include? $type
$searching = ($term != '')

if $searching
    $results = $mpd.search $type, $term
end

out = ERB.new(File.read('views/search.html'))
print out.result
