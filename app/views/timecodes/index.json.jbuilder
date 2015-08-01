json.array!(@timecodes) do |timecode|
  json.extract! timecode, :id, :start_time, :end_time
  json.url timecode_url(timecode, format: :json)
end
