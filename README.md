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
important, where it goes to...

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

Muecken in it's most basic sense takes data from a source like a CSV file or an
API, parses and analyzes it so that you end up with categorized entries. While
entries represent transactions (e.g. paying your rent or getting your salary),
categories are defined by user and therefore completely dynamic.

The creation of fancy diagrams and reports is not part of this library. Once
Muecken is stable I'll start working on an app that does this kind of things. In
case you are interested in collaborating on something in that direction feel
free to contact me!

The main design goals for this library are simplicity, speed and stability - so
I'm using the Ruby standard library as much as possible.

Check out the [TODO list](TODO.md) to find out more about the things I have in
mind.

## Usage

**As mentioned earlier: This is still a very early version and the API is
subject to change!**

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

The main task of Muecken is the assignment of the right categories to an entry.
The biggest part of this categorization happens in an automated way based on a
few manual assignments the user does. Whenever an entry cannot be categorized
the user should specify a category manually. The library will "learn" from that
and categorize future entries properly.

### Categories & Secondary Categories

An entry has to belong to one category and optionally to multiple secondary
categories. For example a category could be "Groceries", "Rent" or "Running
Costs" while "2014", "More than 100€" or "Credit Card" would be secondary
categories.

### How it works

For each entry the following steps are executed:

- Loop through all defined categories and assign matching ones to the entry
- Raise an error if the entry does not have at least one type category
  - This error needs to be caught so that a manual categorization can be done

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
