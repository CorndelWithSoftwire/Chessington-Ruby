# Chessington

Starter project for a chess based TDD exercise in Ruby

## Installation

Execute

    $ bundle install

## Running the tests

To run the tests, use `$ bundle exec rake test`, which will run all the tests in the files located in the `test` directory. Alternatively, you can run each test/group of tests individually in RubyMine by clicking the green arrow to the left of the test function/class

## GUI

### Windows

Make sure to have installed Ruby through the following instructions:

Install [Ruby+Devkit](https://rubyinstaller.org/downloads/) from [RubyInstaller](https://rubyinstaller.org). When prompted to run `ridk install` at the end, go ahead with it, and then make sure to run all 3 commands in order:

1. MSYS2 base installation
2. MSYS2 system update
3. MSYS2 and MINGW development toolchain

Make sure this Ruby version is set in the RubyMine settings


Alternatively, you may be able to run the GUI through WSL if you are on Windows 11 or if you set up a standalone X server and forward it through, though this is somewhat tricky.

### Mac

On the Mac, make sure to:
- Have [Homebrew](https://brew.sh/) installed
- Run this [Homebrew](https://brew.sh/) command to have GTK display GUI icons: `brew install adwaita-icon-theme`
- (Optional) You can upgrade your GTK3/GTK4/GTK+ by running: `brew install gtk+3` / `brew install gtk+4` / `brew install gtk+`

### Linux

Should work out of the box on Linux, but if not, make sure you have GTK3 installed (`libgtk3-dev` on Debian based distributions)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
