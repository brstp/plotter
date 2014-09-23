json.array!(@boats) do |boat|
  json.extract! boat, :id, :name, :period, :start_number
  json.url boat_url(boat, format: :json)
end
