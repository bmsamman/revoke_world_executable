# RevokeWorldExecutable

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/revoke_world_executable`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'revoke_world_executable', github: 'bmsamman/revoke_world_executable '
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bmsamman-revoke_world_executable -s http://gems.github.com

## Usage

Usage: fix_world_executable <options> <path>
        # path defaults to '.' if not specified
        -r, --recursive                  Recursively go through the path.
        -v, --verbose                    Run with more verbosity.
        -d, --dry                        Show changes only, do not apply.
        -h, --help                       Show this message

## Development

After checking out the repo, run `bundle` to install dependencies.

To run the tests:
```ruby
rake test
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

