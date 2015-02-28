require 'neo4j-core'
require_relative 'song'

module AudioliciousToNeo4j
  class SongRepo
    
    ALL_SONGS = 'MATCH (song:Song)<-[:CONTAINS]-(album:Album)<-[:MADE]-(artist:Artist)'\
    ' RETURN artist.name as artist, album.name as album, album.artist_album as album_key, song.name as name, song.artist_album_song as key'
    
    MERGE_SONG = 'MERGE (artist:Artist { name:{artist} })'\
      ' MERGE (album:Album { name:{album}, artist_album:{album_key} })'\
      ' MERGE (artist)-[r:MADE]->(album)'\
      ' MERGE (song:Song {name:{name}, artist_album_song: {song_key}})'\
      ' MERGE (album)-[s:CONTAINS]->(song)'\
      ' RETURN artist.name as artist, album.name as album, album.artist_album as album_key, song.name as name, song.artist_album_song as key'

    DELETE_ALL_SONG_RELATIONSHIPS = 'MATCH (song:Song)<-[r]-() DELETE r'
    DELETE_ALL_ALBUM_RELATIONSHIPS = 'MATCH (album:Album)<-[r]-() DELETE r'
    DELETE_ALL_SONGS = 'MATCH (song:Song) DELETE song'
    DELETE_ALL_ALBUMS = 'MATCH (album:Album) DELETE album'
    DELETE_ALL_ARTISTS = 'MATCH (artist:Artist) DELETE artist'
    
    def initialize
      puts 'Opening Neo4j session...'
      @session = Neo4j::Session.open(:server_db)
      # @session.start
      puts 'Session opened.'
    end
    
    def save(song)
      savedNode = Neo4j::Session.
          query(MERGE_SONG,artist: song.artist, album: song.album, album_key: song.album_key, name: song.name, song_key: song.key).first
      
      savedSong = Song.new(savedNode[:artist], savedNode[:album], savedNode[:name], savedNode[:album_key], savedNode[:key])
      
      raise "Saved song [#{savedSong}] key does not match expectations of song to save [#{song}]." if savedSong.key != song.key
      return savedSong
    end
    
    def all_songs
      Neo4j::Session.query(ALL_SONGS).
          map{|song| Song.new(song[:artist], song[:album], song[:name], song[:album_key], song[:key]) }
    end
    
    def delete_all
      Neo4j::Session.query(DELETE_ALL_SONG_RELATIONSHIPS)
      Neo4j::Session.query(DELETE_ALL_ALBUM_RELATIONSHIPS)
      Neo4j::Session.query(DELETE_ALL_SONGS)
      Neo4j::Session.query(DELETE_ALL_ALBUMS)
      Neo4j::Session.query(DELETE_ALL_ARTISTS)
    end
    
    def close
      @session.close
    end
  end
end