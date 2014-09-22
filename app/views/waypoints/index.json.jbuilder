json.array!(@waypoints) do |waypoint|
  json.extract! waypoint, :id, :name, :latitude, :longitude
  json.url waypoint_url(waypoint, format: :json)
end
