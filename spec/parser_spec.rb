require 'spec_helper'

include AudioliciousToNeo4j

REDUCED_LIBRARY = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'iTunes Music Library reduced.xml')
COMPLETE_LIBRARY = File.join(File.dirname(__FILE__), '..', 'spec', 'data', 'iTunes Music Library.xml')

def reduced_repo
  repo = StubRepo.new
  parser = Parser.new(repo)
  parser.parse(REDUCED_LIBRARY)
  repo
end

describe Parser do

  it 'fails if cannot open file on parse' do
    parser = Parser.new(nil)
    expect{ parser.parse('Does not exist') }.to raise_error
  end

  it 'parses all songs from a file' do
    repo = reduced_repo
    expect(repo.all_songs.size).to eq(54)
  end

  it 'parses all artists from a file' do
    repo = reduced_repo
    expect(repo.all_songs.map{|song| song.artist}.uniq.size).to eq(2)
  end

  it 'parses correct artists from a file' do
    repo = reduced_repo
    expect(repo.all_songs.map{|song| song.artist}.uniq).to include('Slipknot')
    expect(repo.all_songs.map{|song| song.artist}.uniq).to include('Monster Magnet')
    expect(repo.all_songs.map{|song| song.artist}.uniq).not_to include('Metallica')
  end

  it 'parses correct artists from a file' do
    repo = reduced_repo
    expect(repo.all_songs.map{|song| song.name}.uniq).to include('Wait and Bleed')
    expect(repo.all_songs.map{|song| song.name}.uniq).not_to include('Spaceman')
  end

  it 'parses entire complete library file' do
    repo = SongRepo.new
    parser = Parser.new(repo)
    parser.parse(COMPLETE_LIBRARY)
    expect(repo.all_songs.size).to eq(18190)
  end
  
end

class StubRepo
  attr_reader :all_songs
  def initialize
    @all_songs = Array.new
  end
  
  def save(song)
    @all_songs.push(song)
  end
end