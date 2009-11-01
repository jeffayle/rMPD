#!/usr/bin/ruby
#Contains common connection stuff
begin
    require 'librmpd'
    require 'config'
rescue LoadError
    require '../librmpd'
    require '../config'
end

$mpd = MPD.new $config[:host], $config[:port]
$mpd.connect

#Extra functionality
require 'cgi'
class String
    def url_encode()
        CGI::escape self
    end
    
    def url_decode()
        CGI::unescape self
    end

    def html_encode()
        CGI::escapeHTML self
    end
end

#Case insensitive sorting
class Array
    def sort_nocase
        self.sort do |a, b|
            a.upcase <=> b.upcase
        end
    end
end
