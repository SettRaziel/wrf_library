# WRF library
[![Ruby](https://github.com/SettRaziel/wrf_library/actions/workflows/ruby.yml/badge.svg?branch=development)](https://github.com/SettRaziel/wrf_library/actions/workflows/ruby.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/8e22d6851e065fddf8a3/maintainability)](https://codeclimate.com/github/SettRaziel/wrf_library/maintainability)

This project holds a collection of common scripts and data structures for my ruby WRF forecast projects.

Current version: v0.7.0

## Usage & Help
The scripts and classes will be imported in other projects, so there will be not explicit usage.
To use it as a gem define it in your Gemfile like this: 
```
git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }
gem 'ruby_utils', github: 'SettRaziel/ruby_utils'
```
For details check the documentation.

## Documentation
The documentation will be created with yard and published at a later point.

## Used version
Written with Ruby 2.4.0

## Tested
* Linux: running on ArchLinux with Ruby > 2.4.0
* Windows: not tested
* MAC: not tested

## Requirements
* Ruby with a version >= 2.4.0
* yard (for documentation only)
* csv (for reading input files)
* json (for converting meteogram data)
* date (for sunset equation)
* check Gemfile and gemspec for other dependencies

## License
see LICENSE

## Roadmap
see issues

created by: Benjamin Held, June 2018
