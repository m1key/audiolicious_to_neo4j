module AudioliciousToNeo4j
  class Song
    attr_reader :artist, :album, :name, :key
    def initialize(artist, album, name, key)
      @artist = artist
      @album = album
      @name = name
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