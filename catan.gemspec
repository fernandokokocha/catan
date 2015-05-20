Gem::Specification.new do |s|
  s.name          = 'catan'
  s.version       = '0.0.2'
  s.date          = '2015-05-11'
  s.summary       = 'The Settlers of Catan board game simulator'
  s.author        = 'Bartosz Krajka'
  s.authors       = ['Bartosz Krajka']
  s.email         = 'krajka.bartosz@gmail.com'
  s.files         = ['lib/catan.rb'] + Dir['lib/entities/*.rb'] + Dir['lib/controllers/*.rb']
  s.license       = 'MIT'
  s.platform      = Gem::Platform.local
end
