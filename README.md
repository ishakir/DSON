# DSON

Such serialization! Totally pure-ruby also completely DSON. Wow!

Currently known deficiencies:
* Number handling (needs to be octal, currently treated as string)
* Have not implemented yes, no or empty

## Installation

Add this line to your application's Gemfile:

    gem 'DSON'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install DSON

## Usage

Currently supports a ruby hash and array data structure and outputs it's representation in DSON ([Doge Serialized Object notation](http://dogeon.org/)). By way of an example, try:

    require 'DSON'

    puts DSON.such_serialize_wow({
      ruby: 'pure',
      supports: [
        'hash',
        'array'
      ]
    })

This should output:

    such "ruby" is "pure", "supports" is so "hash" also "array" many wow

Correct to the DSON spec

## Contributing

1. Fork it ( https://github.com/[my-github-username]/DSON/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
