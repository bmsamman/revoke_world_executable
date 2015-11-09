require 'test/unit'
require 'tempfile'
require_relative '../../lib/revoke_world_executable'

include RevokeWorldExecutable

class WorldExecutableTest < Test::Unit::TestCase

  def setup
    @file = Tempfile.new('test.rb')
    @path = @file.path
    @world_executable = WorldExecutable.new(@file.path)
  end

  def teardown
    @file.unlink
  end

  def test_permissible?
    assert_not_executable
    FileUtils.chmod( 'o+x', @path )
    assert_executable
    FileUtils.chmod( 'o-x', @path )
    assert_not_executable
  end

  def test_world_executable_assignment
    @world_executable.revoke!
    assert_not_executable
    @world_executable.permit!
    assert_executable
    @world_executable.revoke!
    assert_not_executable
  end

  def test_world_executable_exception
    p = WorldExecutable.new('NotRealFile')
    assert_raise{ p.permit!}
  end

  private

  def assert_not_executable
    assert_false @world_executable.permissible?
  end

  def assert_executable
    assert @world_executable.permissible?
  end

end