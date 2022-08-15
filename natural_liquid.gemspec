# frozen_string_literal: true

require_relative "lib/natural_liquid/version"

Gem::Specification.new do |spec|
  spec.name          = "natural_liquid"
  spec.version       = NaturalLiquid::VERSION
  spec.authors       = ["Dylan Blakemore"]
  spec.email         = ["dylan.blakemore@gmail.com"]

  spec.summary       = "Adds natural language functions to liquid templates"
  spec.description   = "A library which adds functionality for creating more natural-sounding texts with simpler templates"
  spec.homepage      = "https://github.com/DylanBlakemore/natural_liquid"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://mygemserver.com"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DylanBlakemore/natural_liquid"
  spec.metadata["changelog_uri"] = "https://github.com/DylanBlakemore/natural_liquid/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "liquid"
  spec.add_dependency "indefinite_article"
  spec.add_dependency "numbers_and_words"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
