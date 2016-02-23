class SearchController < ApplicationController
  
  
  def index
    @search = ""
    query  = params[:q]
    @results = PgSearch.multisearch(query)
  end
  
end
