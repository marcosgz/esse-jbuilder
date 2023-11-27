# frozen_string_literal: true

require_relative "lib/esse/jbuilder/version"

Gem::Specification.new do |spec|
  spec.name = "esse-jbuilder"
  spec.version = Esse::Jbuilder::VERSION
  spec.authors = ["Marcos G. Zimmermann"]
  spec.email = ["mgzmaster@gmail.com"]

  spec.summary = "Extensions for the Esse Search using Jbuilder DSL"
  spec.description = "Extends the Esse Search using Jbuilder DSL to build the request body"
  spec.homepage = "https://github.com/marcosgz/esse-jbuilder"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/marcosgz/esse-jbuilder"
  spec.metadata["changelog_uri"] = "https://github.com/marcosgz/esse-jbuilder/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "esse", ">= 0.2.4"
  spec.add_dependency "jbuilder", ">= 2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"
end
