require 'logger'

module RevokeWorldExecutable
  class Runner
    attr_reader :options

    def initialize
      @options = RunnerOptions.options
      @options.logger = setup_logger
      @fixer = WorldExecutableFixer.new(@options.target, @options)
    end

    def run
      if @options.recursive
        @fixer.execute_recursive
      else
        @fixer.execute
      end
    end

    def self.run
      new.run
    end

    private

    def setup_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO unless options.verbose
      logger.formatter = proc do |severity, datetime, progname, msg|
       "#{datetime.strftime('%Y/%m/%d %H:%M:%S')} [#{severity}]: #{msg}\n"
      end
      logger
    end
  end
end