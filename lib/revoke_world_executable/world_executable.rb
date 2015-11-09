require 'fileutils'

module RevokeWorldExecutable

  class WorldExecutable
    attr_reader :path

    def initialize( path )
      @path = path
    end

    def permissible?
      world_permissions.odd?
    end

    def revoke!
      FileUtils.chmod( 'o-x', @path )
    end

    def permit!
      FileUtils.chmod( 'o+x', @path )
    end

    private

    def world_permissions
      mode_in_int = File.stat(@path).mode
      mode_str = mode_in_int.to_s(8)
      mode_str[-1].to_i
    end

  end

end