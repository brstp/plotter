require 'csv'

namespace :import do
  namespace :sthlm2014h do
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
    
    task :rounds => :environment do
      Round.destroy_all
      CSV.foreach('lib/tasks/rounds.csv', :headers => false) do |row| 
        boat = Boat.find_by(start_number: row[0])
        row.shift
        for round in row do
          unless round.blank? 
            waypoint = Waypoint.find_by(name: round)
            boat.add_round(waypoint)
          end
        end
      end
    end
  end 
  

  namespace :sthlm2014v do
    task :waypoints => :environment do
      Waypoint.destroy_all
      CSV.foreach('lib/tasks/waypoints.csv', :headers => true) do |row|
        Waypoint.create(row.to_hash)
      end
    end
    
    task :boats => :environment do
      Boat.destroy_all
      CSV.foreach('lib/tasks/boats2.csv', :headers => true) do |row|
        Boat.create(row.to_hash)
      end
    end
    
    task :rounds => :environment do
      Round.destroy_all
      CSV.foreach('lib/tasks/rounds2.csv', :headers => false) do |row| 
        boat = Boat.find_by(start_number: row[0])
        row.shift
        for round in row do
          unless round.blank? 
            waypoint = Waypoint.find_by(name: round)
            boat.add_round(waypoint)
          end
        end
      end
    end
  end 

end 