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
    song = Song.new(artist, album, name, nil, nil)
    expect(song.key).to eq("#{artist}___#{album}___#{name}")
  end

  it 'generates album key when not provided' do
    artist = 'Metallica'
    album = 'Reload'
    name = 'Fuel'
    song = Song.new(artist, album, name, nil, nil )
    expect(song.album_key).to eq("#{artist}___#{album}")
  end

  it 'equals another song with the same key' do
    artist = 'Metallica'
    album = 'Reload'
    name = 'Fuel'
    song1 = Song.new(artist, album, name, nil, nil)
    song2 = Song.new(artist, album, name, nil, nil)
    expect(song1).to eq(song2)
  end

  it 'does not equal another song with another' do
    artist = 'Metallica'
    album = 'Reload'
    song1 = Song.new(artist, album, 'Fuel', nil, nil)
    song2 = Song.new(artist, album, 'Memory Remains', nil, nil)
    expect(song1).not_to eq(song2)
  end
  
end