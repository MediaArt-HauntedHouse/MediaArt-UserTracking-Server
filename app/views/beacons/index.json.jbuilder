json.array!(@beacons) do |beacon|
  json.extract! beacon, :id
  json.url beacon_url(beacon, format: :json)
end
