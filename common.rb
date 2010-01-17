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

        times = [days_s, hours_s, minutes_s, seconds_s]

        if times.all?{|n| n==0 }
            '0'
        else
            times.join(' ').gsub(/ +/,' ')
        end
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

#Process parameters in a URL
def url_params(url)
    params = Hash.new
    url =~ /\?(.+)$/
    query_string = $1 or return params
    query_string.split('&').each do |p|
        name, value = p.split '=', 2
        params[name.url_decode] = value.url_decode
    end

    params
end

#Tool icons/links for file at position pos on the playlist
def playlist_item_tool(pos, playlist)
    moveUp = (if pos.to_i == 0
        %{<img src="img/spacer.png" width="16" height="16" alt="" />}
    else
        %{<a href="moveUp.rb?#{pos}"><img src="img/arrow_up.png"
        width="16" height="16" alt="move up" /></a>}
    end)

    moveDown = (if pos.to_i == playlist.length-1
        %{<img src="img/spacer.png" width="16" height="16" alt="" />}
    else
        %{<a href="moveDown.rb?#{pos}"><img src="img/arrow_down.png"
        width="16" height="16" alt="Move Down" /></a>}
    end)
<<EOF
    <a href="remove.rb?#{pos}">
        <img src="img/delete.png" alt="Remove" width="16" height="16" />
    </a>
    #{moveUp}
    #{moveDown}
EOF
end

#Tool icons/links for search results & browsing
def file_tools(filename)
<<EOF
    <a href="plAdd.rb?#{filename.url_encode.html_encode}">
        <img src="img/add.png" alt="Add to playlist" width="16" height="16" />
    </a>
    <a href="stream.rb?#{filename.url_encode.html_encode}">
        <img src="img/music.png" alt="Stream audio" width="16" height="16" />
    </a>
EOF
end

#Returns the parent of a directory
def dir_parent(directory)
    p = directory.dup
    if p =~ /\//
        p.sub /\/[^\/]+$/, ''
    else
        ''
    end
end

#Gets the name of the album art for a song by filenmae
def album_art(song)
    directory = dir_parent song
    
    album_art_bydir directory
end
#Gets the album art for a directory
def album_art_bydir(directory)
    listing = Dir.glob($config[:mdir] + '/' + directory + '/*')
    listing.map!{|f| [f, File.basename(f)]}
    listing.each do |f|
        return f[0] if $config[:albumArtFiles].include? f[1].downcase
    end

    #Recurse into parent directories
    if directory == ''
        nil
    else
        album_art_bydir(dir_parent(directory))
    end
end
