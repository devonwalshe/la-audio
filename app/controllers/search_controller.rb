class SearchController < ApplicationController
  
  
  def index
    @search = ""
    query  = params[:q]
    @results = Recording.search_tags(query)
  end
  
end
