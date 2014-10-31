# Muecken

[![Build Status](https://travis-ci.org/dsager/muecken.svg?branch=master)](https://travis-ci.org/dsager/muecken)
[![Test Coverage](https://codeclimate.com/github/dsager/muecken/badges/coverage.svg)](https://codeclimate.com/github/dsager/muecken)
[![Code Climate](https://codeclimate.com/github/dsager/muecken/badges/gpa.svg)](https://codeclimate.com/github/dsager/muecken)

Ruby library to parse and analyze financial data. This library is work in
progress and not really usable yet. Feel free to look around but don't expect
too much ;)

Muecken (German for "mosquitos", an informal word for money) is supposed to
provide an easy way of parsing, analyzing and categorizing financial data to
give you an overview of where money comes from and, most probably more
important, where it goes.

```                                                       

  +-------+       +---------+       +------------+   
  |       |       |         |       |            |   
  |  CSV  | +---> |         | +---> |  Entries   |   
  |       |       |         |       |            |   
  +-------+       |         |       +-----+------+   
                  | Muecken |             |          
  +-------+       |         |       +-----+------+   
  |       |       |         |       |            |   
  |  API  | +---> |         | +---> | Categories |   
  |       |       |         |       |            |   
  +-------+       +---------+       +------------+   

```

It basically takes data from a source like a CSV file or an API to parse and
analyze it so that you end up with categorized entries. The task of creating
fancy diagrams and reports is for other apps based on Muecken :)

The main design goals for this library are simplicity, speed and stability - so
I'm using the Ruby standard library as much as possible.

Check out the [TODO list](TODO.md).

## Usage

```ruby
engine = Muecken::Engine.new
engine.add_category example_category
Muecken::Parser::CSV.read_file(file_name).each do |entry|
  engine.categorize_entry(entry)
  engine.add_entry(entry)
end
```

For more examples check the tests under `spec/` or the file `bin/muecken`. I'll
write a proper documentation once the API is more stable...

## Categorization

It is important to make the categorization as straight forward as possible so
that it is actually usable and doesn't end up in too much manual work.

I have some ideas about a learning algorithm, as soon as I'll start working on
it I'll elaborate here...

## Maintainer

[Daniel Sager](https://github.com/dsager)

## Contributing

- Fork
- Implement your Feature or Fix including Tests
- Update the [change log](CHANGELOG.md)
- Create Pull Request (ideally squashed into one commit)

Thank you!

See the [list of contributors](https://github.com/dsager/muecken/contributors).

## License

MIT License, see the [license file](LICENSE).
