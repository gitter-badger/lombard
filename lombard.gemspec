require File.dirname(__FILE__) + '/lib/lombard'

Gem::Specification.new do |s|
  s.name = 'lombard'
  s.version = Lombard.version
  s.date = Date.today.to_s
  s.summary = 'Fetches weather to your terminal'
  s.description = 'Quickly overview weather forecast in your preferred cities.'
  s.homepage = 'https://github.com/acadet/lombard'
  s.authors = [ 'Adrien Cadet' ]
  s.email = 'acadet@live.fr'
  s.files = [ 'README.md', 'bin/lombard', 'lib/lombard.rb' ]
  s.executables = [ 'lombard' ]
  s.license = "MIT"

  # Dependencies
  s.add_dependency 'httparty'
end