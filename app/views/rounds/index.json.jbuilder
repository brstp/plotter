json.array!(@rounds) do |round|
  json.extract! round, :id, :boat_id, :waypoint_id, :position
  json.url round_url(round, format: :json)
end
