# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'revoke_world_executable/version'

Gem::Specification.new do |spec|
  spec.name          = 'revoke_world_executable'
  spec.version       = RevokeWorldExecutable::VERSION
  spec.authors       = ['Bassel Samman']
  spec.email         = ['bmsamman@gmail.com']

  spec.summary       = %q{Gem to revoke world executable permissions on files.}
  spec.description   = %q{Gem to revoke world executable permissions on files.}
  spec.homepage      = 'TODO: Put your gem''s website or public repo URL here.'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files = `git ls-files`.split("\n")
  spec.executables   = ['revoke_world_executable']
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
