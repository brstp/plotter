require 'csv'

namespace :import do
  task :waypoints => :environment do
    Waypoint.destroy_all
    CSV.foreach('lib/tasks/waypoints.csv', :headers => true) do |row|
      Waypoint.create(row.to_hash)
    end
  end
  
  task :boats => :environment do
    Boat.destroy_all
    CSV.foreach('lib/tasks/boats.csv', :headers => true) do |row|
      Boat.create(row.to_hash)
    end
  end
  
      
end 