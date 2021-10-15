require_relative "lib/black_magic/version"

Gem::Specification.new do |spec|
  spec.name          = "black-magic"
  spec.version       = Black::Magic::VERSION
  spec.authors       = ["Ingemar"]
  spec.email         = ["ingemar@xox.se"]

  spec.summary       = "Black magic attribute initialization"
  spec.description   = "Darkside definition of initialization attributes. Use at own risk."
  spec.homepage      = "https://github.com/ingemar/black-magic."
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ingemar/black-magic"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/ingemar/black-magic/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
