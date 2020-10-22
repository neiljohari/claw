require_relative 'lib/claw/version'

Gem::Specification.new do |spec|
  spec.name          = "claw"
  spec.version       = Claw::VERSION
  spec.authors       = ["Neil Johari"]
  spec.email         = ["neil@johari.tech"]

  spec.summary       = %q{A tool for staff to quickly download student AG submissions}
  spec.homepage      = "https://eecs280staff.github.io/eecs280.org/"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/neiljohari/claw/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = ['claw']
  spec.require_paths = ["lib"]
end
