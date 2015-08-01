json.array!(@authors) do |author|
  json.extract! author, :id, :image_url, :bio_text, :name, :job_title, :job_description
  json.url author_url(author, format: :json)
end
