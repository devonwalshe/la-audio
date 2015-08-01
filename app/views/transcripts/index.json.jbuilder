json.array!(@transcripts) do |transcript|
  json.extract! transcript, :id, :body, :audio_id
  json.url transcript_url(transcript, format: :json)
end
