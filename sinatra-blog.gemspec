# -*- encoding: utf-8 -*-

# require File.expand_path('../lib/sinatra-blog/version', __FILE__)

Gem::Specification.new do |gem|

  gem.authors       = ["Wlodek Bzyl"]
  gem.email         = ["matwb@ug.edu.pl"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = "http://tao.inf.ug.edu.pl"

  gem.files         = `git ls-files`.split($\)
#  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
#  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.name          = "sinatra-blog"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.7"

  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'rdiscount'
  gem.add_runtime_dependency 'erubis'
  gem.add_runtime_dependency 'coderay'

end
