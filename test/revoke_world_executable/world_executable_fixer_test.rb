require 'test/unit'
require 'tempfile'
require_relative '../../lib/revoke_world_executable'

include RevokeWorldExecutable

class WorldExecutableFixerTest < Test::Unit::TestCase

  def setup
    @tmpdir = Dir.mktmpdir('path_modifier')
    generate_files
    @logger = Logger.new(STDOUT)
    @path_modifier = WorldExecutableFixer.new(@tmpdir, dry: false, logger: @logger)
  end

  def teardown
    FileUtils.remove_entry @tmpdir
  end

  def test_execute
    results = @path_modifier.execute
    assert_equal results[:changed_successfully], 0
    assert_equal results[:checked], 1
    FileUtils.chmod('o+x', @tmpdir)
    results = @path_modifier.execute
    assert_equal results[:changed_successfully], 1
    assert_equal results[:checked], 1
  end


  def test_execute_recursive
    results = @path_modifier.execute_recursive
    assert_equal results[:changed_successfully], 14
  end

  def test_execute_recursive_dry
    dry_run = WorldExecutableFixer.new(@tmpdir, dry: true, logger: @logger)
    results = dry_run.execute_recursive
    assert_equal results[:changed_successfully], 0
  end

  def test_output
    logger = MockLogger.new
    dry_run = WorldExecutableFixer.new(@tmpdir, dry: true, logger: logger)
    dry_run.execute_recursive
    assert_include(logger.messages[:info], WorldExecutableFixer::DRY_MODE_MSG)
    assert_include(logger.messages[:info], 'Files required change: 14')
    assert_include(logger.messages[:info], 'Files skipped: 14')
    assert_include(logger.messages[:info], 'Files changed successfully: 0')
    assert_include(logger.messages[:info], 'Files checked: 41')
    message = logger.messages[:debug].first
    assert message.include?('Revoking world-executable')
  end
  private

  def generate_files
    directories = %w{a/a1/a2/a3 b/b1}
    directories.each do |dir|
      FileUtils.mkdir_p File.join(@tmpdir, dir), mode: 0744
    end
    Dir[File.join(@tmpdir, '**/**'), @tmpdir].each{|dir| create_files_in( dir )}
  end

  def create_files_in( dir )
    5.times do |index|
      path = File.join(dir, "file_#{index}.rb")
      FileUtils.touch(path)
      if index.odd?
        FileUtils.chmod( 'o+x', path )
      end
    end
  end

  class MockLogger
    attr_reader :messages

    def initialize
      @messages = {info: [], debug: []}
    end


    def info(msg)
      @messages[:info] << msg
    end

    def debug(msg)
      @messages[:debug] << msg
    end
  end
end