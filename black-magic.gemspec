require_relative "lib/black_magic/version"

Gem::Specification.new do |spec|
  spec.name = "black-magic"
  spec.version = Black::Magic::VERSION
  spec.authors = ["Ingemar"]
  spec.email = ["ingemar@xox.se"]

  spec.summary = "Black magic attribute initialization"
  spec.description = "Darkside definition of initialization attributes. Use at own risk."
  spec.homepage = "https://github.com/ingemar/black-magic."
  spec.required_ruby_version = ">= 4.0.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ingemar/black-magic"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/ingemar/black-magic/master/CHANGELOG.md"

  spec.files = []
  spec.files << "README.md"
  spec.files << "CHANGELOG.md"
  spec.files << "LICENSE"
  spec.files.append(*Dir.glob("lib/**/*"))

  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
