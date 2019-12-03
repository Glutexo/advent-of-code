# Advent of Code #

## Introduction ##

This is my attempt to solve the puzzles from the [Advent of Code](https://adventofcode.com/). It starts with the [2019 edition](https://adventofcode.com/2019).

Vanilla [Ruby](http://ruby-lang.org/) was my language of choice. All code is tested by [RSpec](http://rspec.info/).

## Progress ##

* [Day 1](https://adventofcode.com/2019/day/1) – [code](2019/Day%201)
  * [Part 1](https://adventofcode.com/2019/day/1) – [answer](2019/Day%201/output1)
  * [Part 2](https://adventofcode.com/2019/day/1#part2) – [answer](2019/Day%201/output2)
* [Day 2](https://adventofcode.com/2019/day/2) – not started yet

## Installation ##

1. Use [Ruby](http://www.ruby-lang.org/) version 2.6.3.

   ```
   $ brew install rbenv
   $ rbenv install 2.6.3
   $ rbenv local 2.6.3
   ```

2. Go to the Day folder.
3. Bundle all the things.

   ```
   $ bundle install
   ```

4. Run the tests.

   ```
   $ rspec -I lib test/*
   ```
   
5. Run the scripts in the _bin_ folder. Feed them with resources in the _var_ folder.

   ```
   $ ruby -I lib bin/solve.rb var/input 
   ```

## Credits ##

Solved by [Glutexo](http://github.com/Glutexo). 🦎 Cheers!
