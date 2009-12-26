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

class Integer
    #Format as a relative in time as a string
    def to_s_dtime()
        rem = self #Remainder (unprocessed)
        days = rem/86_400 #86'400 seconds in a day
            rem %= 86_400
        hours = rem/3600
            rem %= 3600
        minutes = rem/60
            rem %= 60
        seconds = rem

        days_s = days.quantify 'day','s'
        hours_s = hours.quantify 'hour','s'
        minutes_s = minutes.quantify 'minute','s'
        seconds_s = seconds.quantify 'second','s'

        [days_s,hours_s,minutes_s,seconds_s].join ' '
    end

    def quantify(unit, plural)
        if self == 0
            ''
        elsif self == 1
            "1 #{unit}"
        else
            "#{self} #{unit}#{plural}"
        end
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
