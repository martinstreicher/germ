# frozen_string_literal: true

require_relative 'lib/germ/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'factory_bot', '~> 6.4'
  spec.add_dependency 'faker', '~> 3.2'
  spec.add_dependency 'rails', '~> 8.0'

  spec.authors                           = ['Martin Streicher']
  spec.bindir                            = 'bin'
  spec.description                       = 'Germ provides an object-oriented approach to Rails seed files, making them more maintainable and testable by organizing seed data into classes with clear responsibilities.'
  spec.email                             = ['martin@getbridgecare.com']
  spec.executables                       = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.homepage                          = 'https://github.com/martinstreicher/germ'
  spec.license                           = 'MIT'
  spec.metadata['changelog_uri']         = 'https://github.com/martinstreicher/germ/blob/main/CHANGELOG.md'
  spec.metadata['homepage_uri']          = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['source_code_uri']       = 'https://github.com/martinstreicher/germ'
  spec.name                              = 'germ'
  spec.required_ruby_version             = '>= 3.1.0'
  spec.summary                           = 'An object-oriented approach to seed files.'
  spec.version                           = Germ::VERSION

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)

  spec.files =
    IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
      ls.readlines("\x0", chomp: true).reject do |f|
        (f == gemspec) ||
          f.start_with?(*%w[spec/ features/ .git .github appveyor Gemfile]) ||
          f.end_with?('.gem')
      end
    end

  spec.require_paths = ['lib']
end
