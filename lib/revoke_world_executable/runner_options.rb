require 'optparse'
require 'ostruct'

module RevokeWorldExecutable
  class RunnerOptions
    attr_reader :options

    def initialize
      defaults = { verbose: false, dry: false, recursive: false }
      @options = OpenStruct.new(defaults)
      setup_parser
      @options.target = @parser.default_argv.first || '.'
    end


    def self.options
      new.options
    end

    private

    def setup_parser
      @parser = OptionParser.new
      @parser.banner = 'Usage: fix_world_executable <options> <path>'
      @parser.summary_indent = ' ' * 8
      add_options
      @parser.parse!
    end

    def add_options
      add_option('recursive', 'Recursively go through the path.')
      add_option('verbose', 'Run with more verbosity.')
      add_option('dry', 'Show changes only, do not apply.')
      @parser.on_tail('-h', '--help', 'Show this message') do
        puts(@parser)
        exit
      end
    end

    def add_recursive_option
      add_option('recursive', 'Recursively go through the path.')
    end

    def add_option( name, description )
      @parser.on('-' + name[0], '--' + name, description) do |v|
        @options[ name ] = v
      end
    end

  end
end