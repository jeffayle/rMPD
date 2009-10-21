#MPDr Configuration
$config = Hash.new

#Location of MPD server
$config[:host] = 'localhost'
#Port
$config[:port] = 6600

#Where your music library is, needed for streaming (do not add trailing /)
$config[:mdir] = '/exthd/jeff/Music'

#Where the root of the client can be found over HTTP. (do not add trailing /)
#Make sure that any computer that will be using it can access it on this url.
$config[:httpAddr] = 'http://192.168.1.134/~mpdr'

#Connection stuff
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
