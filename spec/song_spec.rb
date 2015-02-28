require 'spec_helper'

include AudioliciousToNeo4j

describe Song do
  
  it 'preserves the provided song key' do
    key = 'some key'
    song = Song.new('Metallica', 'Reload', 'Fuel', nil, key)
    expect(song.key).to eq(key)
  end

  it 'preserves the provided album key' do
    key = 'some key'
    song = Song.new('Metallica', 'Reload', 'Fuel', key, nil)
    expect(song.album_key).to eq(key)
  end
  
  it 'generates song key when not provided' do
    artist = 'Metallica'
    album = 'Reload'
    name = 'Fuel'
    song = Song.new(artist, album, name, nil, nil )
    expect(song.key).to eq("#{artist}___#{album}___#{name}")
  end

  it 'generates album key when not provided' do
    artist = 'Metallica'
    album = 'Reload'
    name = 'Fuel'
    song = Song.new(artist, album, name, nil, nil )
    expect(song.album_key).to eq("#{artist}___#{album}")
  end
  
end