json.array!(@segments) do |segment|
  json.extract! segment, :id, :audio_id, :start_time, :end_time, :name, :description
  json.url segment_url(segment, format: :json)
end
