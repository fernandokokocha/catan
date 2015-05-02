require_relative '../catan.rb'
Dir['./entities/*.rb'].each{ |f| require f }
Dir['./controllers/*.rb'].each{ |f| require f }