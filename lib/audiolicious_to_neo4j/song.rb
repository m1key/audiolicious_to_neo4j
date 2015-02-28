module AudioliciousToNeo4j
  class Song
    attr_reader :artist, :album, :name, :album_key, :key
    def initialize(artist, album, name, album_key, key)
      @artist = artist
      @album = album
      @name = name
      
      if album_key then
        @album_key = album_key
      else
        @album_key = "#{artist}___#{album}"
      end
      
      if key then
        @key = key 
      else
        @key = "#{artist}___#{album}___#{name}"
      end
    end
    
    def to_s
      "Song [#{key}], artist [#{artist}], album [#{album}], name [#{name}]"
    end
  end
end