require 'neo4j-core'
require_relative 'song'

module AudioliciousToNeo4j
  class SongRepo
    
    ALL_SONGS = 'MATCH (song:Song)<-[:CONTAINS]-(album:Album)<-[:MADE]-(artist:Artist)'\
    ' RETURN artist.name as artist, album.name as album, song.name as name, song.artist_album_song as key'
    
    def initialize
      puts "Opening Neo4j session..."
      @session = Neo4j::Session.open(:server_db)
      # @session.start
      puts "Session opened."
    end
    
    def save(song)
      puts "Saving #{song.name}"
    end
    
    def all_songs
      puts "Getting all songs..."
      Neo4j::Session.query(ALL_SONGS).
          map{|song| Song.new(song[:artist], song[:album], song[:name], song[:key]) }
    end
    
    def close
      @session.close
    end
  end
end