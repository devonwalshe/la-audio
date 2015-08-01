json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :type
  json.url tag_url(tag, format: :json)
end
