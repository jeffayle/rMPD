#!/usr/bin/ruby
#Manages playlists (stuff on playlist.rb)
require 'common'

params = url_params ENV['REQUEST_URI']
playlist = params['pl']
action = params['action']
newname = params['newname'] #Only used when renaming a playlist (action=Rename)

#Make sure that the action is actually one of the available actions
action = 'Play' unless ['Delete','Rename','Save','Play','New'].include? action

#Do that action
if action == 'Play'
    $mpd.clear
    $mpd.load playlist
    $mpd.play 0
elsif action == 'Save'
    $mpd.remove_playlist playlist
    #Cannot overwrite an existing playlist, so must first delete old version
    $mpd.save playlist
elsif action == 'New'
    $mpd.save newname
else
    #For debugging...
    print "Content-Type: text/plain\r\n"
    print "\r\n"
    puts 'Error: Unknown action.'
    p params
    puts ''
end

#Redirect
print "Location: playlists.rb\r\n"
print "\r\n"
