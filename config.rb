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

#Playlist view columns
## Headers
$config[:plHeaders] = [
    '#', 'Title', 'Artist', 'Album', ''
]
## Contents
#Valid options are: artist, composer, track, title, time, id, date, album,
#   genre, file,  pos & tools
#All are the metadata in the audio file except for:
#id is the unique identification number given by MPD
#file is the filename relative to the root of your music directory
#pos is the position in the playlist, 0 is the first song
#Tools is an extra column with stuff to edit the playlist
#
#Each will be replaced with just the corresponding text, except for title,
#which will include a link to skip to that song
$config[:plContent] = [
    'track', 'title', 'artist', 'album', 'tools'
]

#Similarly for browsing files, same options as for playlist
$config[:fbHeadders] = ['Title', 'Artist', 'Year', '']
$config[:fbContent] = ['title', 'artist', 'date', 'tools']
