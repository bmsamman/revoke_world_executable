require_relative 'world_executable'

module RevokeWorldExecutable

  class WorldExecutableFixer
    DRY_MODE_MSG='Running in dry mode.  No actual changes will be applied.'

    def initialize(path, options={})
      @path = path
      @options = options
      @logger = options[:logger] || Logger.new(STDOUT)
    end

    def execute_recursive
      execute File.join(@path, '**/*')
    end

    def execute(target=@path)
      show_explanation_msg
      @total, @affected, @succeeded = 0, 0,0
      Dir[target].each{|file| execute_on file}
      print_and_return_totals
    end

    private

    def execute_on(file)
      world_executable = WorldExecutable.new(file)
      revoke( world_executable ) if world_executable.permissible?
      @total += 1
    end

    def totals
      {required_change: @affected, changed_successfully: @succeeded,
       skipped: @affected - @succeeded, checked: @total}
    end

    def print_and_return_totals
      totals.each_pair do |k,v|
        key_name = k.to_s.sub('_', ' ')
        @logger.info "Files #{key_name}: #{v}"
      end
      totals
    end

    def revoke( permission )
      @affected += 1
      @logger.debug "\tRevoking world-executable permission on " + permission.path
      unless @options[:dry]
        permission.revoke!
        @succeeded += 1
      end
    rescue Exception => e
      @logger.error "Could not change permission for #{permission.path}: #{e.message}"
    end

    def show_explanation_msg
      if @options[:dry]
        @logger.info DRY_MODE_MSG
      else
        @logger.debug 'The following changes will be applied:'
      end
    end

  end

end