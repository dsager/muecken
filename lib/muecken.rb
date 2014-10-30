## Muecken parses and analyzes financial data
module Muecken end
require 'muecken/version'

## Matcher
require 'muecken/matcher/base'
require 'muecken/matcher/levenshtein'
require 'muecken/matcher/date'

## Categories
require 'muecken/categories/rule'
require 'muecken/categories/category'
require 'muecken/categories/helper'

## Entries
require 'muecken/entry'

## Parsers
require 'muecken/parser/csv'

## Engine
require 'muecken/engine'
