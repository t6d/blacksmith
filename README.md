# Blacksmith

Blacksmith uses FontForge to build fonts from SVG graphics.

## Installation

Add this line to your application's Gemfile:

    gem 'blacksmith'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacksmith
    
## Pitfalls

### SVG Viewport

Make sure that all your SVGs contain a `viewBox` definition. Otherwise, weird
things might happen.

### OS X and ttfautohint

If you don't have `ttfautohint` installed and don't want to compile it from
source, you can grab a precompiled version from
[SourceForge](http://sourceforge.net/projects/freetype/files/ttfautohint/).

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
