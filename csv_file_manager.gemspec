# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_file_manager/version"

Gem::Specification.new do |spec|
  spec.name          = "csv-file-manager"
  spec.version       = CsvFileManager::VERSION
  spec.authors       = ["wowonrails"]
  spec.email         = ["wowaonrails@gmail.com"]

  spec.summary       = "Simple CSV file manager"
  spec.description   = "This manager allows to manage data recorded in a CSV file"
  spec.homepage      = "https://github.com/wowonrails/csv-file-manager"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "0.10.4"
  spec.add_development_dependency "faker", "1.8.4"
  spec.add_development_dependency "pry-byebug", "3.5.0"
  spec.add_development_dependency "dotenv-rails", "2.2.1"
  spec.add_development_dependency "codeclimate-test-reporter", "1.0.8"
  spec.add_development_dependency "rubocop", "~> 0.50.0"
  spec.add_development_dependency "bundler-audit", "0.6.0"
end
