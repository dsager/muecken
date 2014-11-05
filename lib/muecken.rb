## Muecken parses and analyzes financial data
module Muecken
end

## Version
require 'muecken/version'

## Matcher
require 'muecken/matcher/base'
require 'muecken/matcher/similarity'
require 'muecken/matcher/sub_string'
require 'muecken/matcher/date'

## Categories
require 'muecken/categories/base'
require 'muecken/categories/primary'
require 'muecken/categories/secondary'

## Entries
require 'muecken/entry'

## Rules
require 'muecken/rules/base'
require 'muecken/rules/all_match'
require 'muecken/rules/one_match'
require 'muecken/rules/builder'

## Parsers
require 'muecken/parser/csv'
