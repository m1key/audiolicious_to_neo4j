require 'spec_helper'

include AudioliciousToNeo4j

describe SongRepo do

  before(:each) do
    begin
      @repo = SongRepo.new
    rescue Faraday::ConnectionFailed => e
      raise "Failed to connect to the database. Got [#{e}]."
    end
  end

  it 'does not return unsaved songs' do
    song = Song.new('Michal Huniewicz', 'Greatest Hits', '"V" Is for Vagina', nil, nil)
    expect(@repo.all_songs).not_to include(song), 'Unexpected search results - returned a song that was never saved.'
  end

  it 'saves a song and returns it' do
    song = Song.new('Monster Magnet', 'Spine of God', 'Sin\'s a Good Man\'s Brother', nil, nil)
    @repo.save(song)
    expect(@repo.all_songs).to include(song), 'Song not saved correctly or not returned correctly.'
  end

  it 'deletes all Audiolicious data' do
    song = Song.new('Marilyn Manson', 'Holy Wood (In the Shadow of the Valley of Death)', 'Target Audience (Narcissus Narcosis)', nil, nil)
    @repo.save(song)
    @repo.delete_all
    expect(@repo.all_songs.size).to eq(0), 'Not all Audiolicious data has been deleted.'
  end
  
  after(:all) do
    @repo.close if @repo != nil
  end
end