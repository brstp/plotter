require 'csv'

namespace :import do
  task :waypoints => :environment do
    csv_text = File.read('lib/tasks/pod.csv')
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      waypoint = find_by_id(row["name"]) || new
      waypoint.attributes = row.to_hash.slice(*accessible_attributes)
      waypoint.save!
    end
  end
end 