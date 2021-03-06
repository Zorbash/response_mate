lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'response_mate/version'

Gem::Specification.new do |spec|
  spec.name          = 'response_mate'
  spec.version       = ResponseMate::VERSION
  spec.authors       = ['Dimitris Zorbas']
  spec.email         = ['zorbash@skroutz.gr']
  spec.description   = <<-DESC
    Cli tool to make inspecting and recording HTTP requests fun again
  DESC
  spec.summary       = %q(A cli tool for browsing and recording api requests with ease)
  spec.homepage      = 'https://github.com/Zorbash/response_mate'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'awesome_print'
  spec.add_dependency 'activesupport', '< 5.0.0'
  spec.add_dependency 'colorize', '> 0.7.5'
  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'addressable'
  spec.add_dependency 'highline'
  spec.add_dependency 'mustache', '< 1.0.0'
end
