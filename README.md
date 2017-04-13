# File::Tail for Ruby

## Description

This is a small ruby library that allows it to "tail" files in Ruby, including
following a file, that still is growing like the unix command 'tail -f' can.

## Download

The latest version of *File::Tail* (file-tail) can be found at


http://flori.github.com/file-tail

## Installation

To install file-tail via its gem type:

# gem install file-tail

## Usage

File::Tail is a module in the File class. A lightweight class interface for
logfiles can be seen under File::Tail::Logfile.

Direct extension of File objects with File::Tail works like that:

    File.open(filename) do |log|
      log.extend(File::Tail)
      log.interval # 10
      log.backward(10)
      log.tail { |line| puts line }
    end

It's also possible to mix File::Tail in your own File classes
(see also File::Tail::Logfile):

    class MyFile < File
      include File::Tail
    end
    log # MyFile.new("myfile")
    log.interval # 10
    log.backward(10)
    log.tail { |line| print line }

The forward/backward method returns self, so it's possible to chain
methods together like that:

    log.backward(10).tail { |line| puts line }

A command line utility named rtail, that uses File::Tail is provided as well.

## Documentation

To create the documentation of this module, type

```
$ rake doc
```

and the API documentation is generated.

In the examples direcotry is a small example of tail and
pager program that use this module. You also may want look
at the end of examples/tail.rb for a little example.

## Author

Florian Frank mailto:flori@ping.de

## License

Apache License, Version 2.0 – See the COPYING file in the source archive.
