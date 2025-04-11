# frozen_string_literal: true

require_relative 'lib/germ/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'factory_bot'
  spec.add_dependency 'faker'
  spec.add_dependency 'rails', '~> 8.0'

  spec.authors                           = ['Martin Streicher']
  spec.bindir                            = 'exe'
  spec.description                       = 'An object-oriented approach to seed files.'
  spec.email                             = ['martin@getbridgecare.com']
  spec.executables                       = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
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
          f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
      end
    end

  spec.require_paths = ['lib']
end
