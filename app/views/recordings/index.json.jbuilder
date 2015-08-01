json.array!(@recordings) do |recording|
  json.extract! recording, :id
  json.url recording_url(recording, format: :json)
end
