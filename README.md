# Mars Rovers

![Image of Mars Rovers](http://i.imgur.com/l6c8UNO.png)

## Install

```bash
$ git clone git@github.com:aliaksandrb/mars_rovers.git
$ cd mars_rovers
$ bundle
$ rake # to run the tests suite
```

## Usage example
```ruby
# within mars_rovers folder

$ irb

$LOAD_PATH.push('lib')
require 'play'
Mars::Play.run('tests/fixtures/input.txt') # or any other path with an input
```

:see_no_evil:
