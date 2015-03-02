require 'nokogiri'

module AudioliciousToNeo4j
  class Parser
    def initialize(repo)
      @repo = repo
    end
    
    def parse(file_name)
      f = File.open(file_name)
      doc = Nokogiri::XML(f)
      doc.xpath('//plist/dict/dict/dict').each do |thing|
        name = thing.at_xpath('key[text()="Name"]/following-sibling::node()').content
        
        album_node = thing.at_xpath('key[text()="Album"]/following-sibling::node()')
        next if album_node == nil
        album = album_node.content
        
        artist_node = thing.at_xpath('key[text()="Album Artist"]/following-sibling::node()')
        if artist_node == nil then
          artist_node = thing.at_xpath('key[text()="Artist"]/following-sibling::node()')
        end
        next if artist_node == nil
        artist = artist_node.content
        
        song = AudioliciousToNeo4j::Song.new(artist, album, name, nil, nil)
        @repo.save(song)
      end
    ensure
      f.close unless f.nil?
    end
  end
end
