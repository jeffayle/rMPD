#MPDr Configuration
$config = Hash.new

#Location of MPD server
$config[:host] = 'localhost'
#Port
$config[:port] = 6600

#Where your music library is, needed for streaming (do not add trailing /)
$config[:mdir] = '/exthd/jeff/music'

#Connection stuff
require 'rubygems'
require 'librmpd'
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
