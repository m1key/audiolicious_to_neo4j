require 'spec_helper'

include AudioliciousToNeo4j

describe Song do
  it 'preserves the provided key' do
    key = "some key"
    song = Song.new("Metallica", "Reload", "Fuel", key)
    expect(song.key).to eq(key)
  end
  it 'generates key when not provided' do
    artist = 'Metallica'
    album = 'Reload'
    name = 'Fuel'
    song = Song.new(artist, album, name, nil)
    expect(song.key).to eq("#{artist}___#{album}___#{name}")
  end
end