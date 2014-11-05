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
categories are defined by the user and therefore completely dynamic.

The creation of fancy diagrams and reports is not part of this library. Once
Muecken is stable I'll start working on an app that does this kind of things. In
case you are interested in collaborating on something in that direction feel
free to contact me!

The main design goals for this library are simplicity, speed and stability - so
I'm using the Ruby standard library as much as possible.

Check out the [TODO list](TODO.md) to find out more about the things I have in
mind.

## Usage

The following snippet will create a rule which adds the category "Phone" to
entries containing one of the words "jazztel", "orange" or "movistar". It then
loads a list of entries from a CSV file and applies the rule to each of them.

```ruby
# declare rule
rules = []
rules << Muecken::Rules::OneMatch.new(
 [
   Muecken::Matcher::SubString.new(%w(jazztel)),
   Muecken::Matcher::SubString.new(%w(orange)),
   Muecken::Matcher::SubString.new(%w(movistar))
 ],
 [Muecken::Categories::Primary.new('Phone')]
)
# load entries
entries = Muecken::Parser::CSV.read_file(file_name)
# categorize entries
rules.product(entries) { |rule, entry| rule.apply(entry) }
```

A rule needs at least one matcher and at least one category. If one of the
matcher matches, all the categories are assigned (depending on the rule type it
can be required that all matcher need to match).

For more examples check the tests under `spec/` or the reference implementation
[Muecken CLI](https://github.com/dsager/muecken-cli).

## Categories

There are two types of categories: primary and secondary. The idea is that an
entry has one primary category and optionally multiple secondaries. For example
a primary category could be "Groceries", "Rent" or "Running Costs" while "2014",
"More than 100€" or "Credit Card" would be secondary ones. The specific
implementation of this is up to the consumer though, you can also just use one
type and don't care about the other.

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
