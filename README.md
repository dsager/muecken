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

**As mentioned earlier: This is still a very early version and the API is
subject to change!**

The following snippet will create the engine, add some YAML-serialized rules and
a custom one. Then it reads a CSV file of entries and categorizes them.
```ruby
# declare rules
rules = YAML.load_file(rule_file)
rules << example_rule
# load entries
entries = Muecken::Parser::CSV.read_file(file_name)
# categorize entries
entries.each { |entry| rules.each { |rule| rule.apply(entry) } }

```

### Defining Rules

A rule needs at least one matcher and at least one category. If one of the
matcher matches, all the categories are assigned (depending on the rule type it
can be required that all matcher need to match).

```ruby
engine.add_rule Muecken::Rules::OneMatch.new(
  [
    Muecken::Matcher::SubString.new(%w(jazztel)),
    Muecken::Matcher::SubString.new(%w(orange)),
    Muecken::Matcher::SubString.new(%w(movistar))
  ],
  [Muecken::Categories::Primary.new('Phone / Internet')]
)
require 'yaml'
puts engine.category.to_yaml
```

This would output a YAML-serialized rule array like this:

```yaml
---
- !ruby/object:Muecken::Rules::OneMatch
  matcher:
  - !ruby/object:Muecken::Matcher::SubString
    sub_strings:
    - orange
  - !ruby/object:Muecken::Matcher::SubString
    sub_strings:
    - jazztel
  - !ruby/object:Muecken::Matcher::SubString
    sub_strings:
    - movistar
  categories:
  - !ruby/object:Muecken::Categories::Primary
    name: Phone / Internet
```

This rule would categorize every entry that contains one of the words "jazztel",
"orange" or "movistar" as "Phone / Internet".

For more examples check the tests under `spec/` or the reference implementation
[Muecken CLI](https://github.com/dsager/muecken-cli).

## Categorization

The main task of Muecken is the assignment of the right categories to an entry.
The biggest part of this categorization happens in an automated way based on a
few manual assignments the user does. Whenever an entry cannot be categorized
the user should specify a category manually. The library will "learn" from that
and categorize future entries properly.

### Primary & Secondary Categories

An entry has to belong to one primary category and optionally to multiple
secondary categories. For example a category could be "Groceries", "Rent" or
"Running Costs" while "2014", "More than 100€" or "Credit Card" would be
secondary ones.

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
