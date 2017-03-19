class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
    @topics = Tag.all.order(:name).uniq
    @topic_rows = randomize_layout(@topics)

    
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:name, :type)
    end
    
    ## Creates a shuffled view
    ## define items per row and how many layouts
    ## NOTE - last layout has less items than the rest of the rows
    def randomize_layout(tags)
      
      # How many layouts do we have? How many per row?
      n_layouts = 4
      n_per_row = 3
      
      # initlize layout groups
      layout_styles = []
      
      # initialize groups
      tag_rows = {}
      
      # Set up full layout groups
      n_full_groups = tags.each_slice(n_per_row).count/n_layouts
      n_full_groups.times do |i|
        layout_styles << ((1..n_layouts-1).to_a.sample(n_layouts-1) << rand(1..n_layouts-1)).flatten
      end
      
      ### Add odd remainder layout if the last one isn't full
      if tags.each_slice(n_per_row).count%n_layouts != 0
        # one with the remainder
        # n_remainder = tags.each_slice(n_per_row).count % n_layouts
        layout_styles << [n_layouts]
      end
      
      # flatten layout styles
      layout_styles = layout_styles.flatten(1)
      
      #Get tags into groups
      tags.each_slice(3).to_a.each_with_index do |tg, i|
        tag_rows["tag_row_#{i+1}"] = {:style => "layout_#{layout_styles[i]}", :tags => tg}
      end
      
      # Return
      return tag_rows
      
    end
      
end
