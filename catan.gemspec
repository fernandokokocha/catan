Gem::Specification.new do |s|
  s.name          = 'catan'
  s.version       = '0.0.0'
  s.date          = '2015-04-04'
  s.summary       = 'The Settlers of Catan board game simulator'
  s.author        = 'Bartosz Krajka'
  s.authors       = ['Bartosz Krajka']
  s.email         = 'krajka.bartosz@gmail.com'
  s.files         = ['lib/catan.rb',
                     'lib/entities/map.rb',
                     'lib/entities/field.rb',
                     'lib/entities/place.rb']
  s.license       = 'MIT'
  s.platform      = Gem::Platform.local
end