# AudioliciousToNeo4j

Migrating iTunes library file to Neo4j.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'audiolicious_to_neo4j'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install audiolicious_to_neo4j

## Usage

> ./bin/console

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

If nokogiri fails to install, you might be missing some libraries. On Fedora, this helps:

> sudo yum install libxml2-devel libxslt libxslt-devel

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Neo4j setup queries:

> CREATE CONSTRAINT ON (artist:Artist) ASSERT artist.name IS UNIQUE
> CREATE CONSTRAINT ON (album:Album) ASSERT album.artist_album IS UNIQUE
> CREATE CONSTRAINT ON (song:Song) ASSERT song.artist_album_song IS UNIQUE

To run tests:

> rspec spec

To build gem:

> gem build audiolicious_to_neo4j.gemspec

To install gem:

> gem install audiolicious_to_neo4j-0.1.0.gem

To test gem:

> irb

> require 'audiolicious_to_neo4j'

## Contributing

1. Fork it ( https://github.com/[my-github-username]/audiolicious_to_neo4j/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
