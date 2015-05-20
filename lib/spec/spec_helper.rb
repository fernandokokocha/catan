require_relative '../catan.rb'
Dir['../entities/*.rb'].each{ |f| require_relative f }
Dir['../controllers/*.rb'].each{ |f| require_relative f }