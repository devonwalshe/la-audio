class RecordingsController < ApplicationController
  include NodeImport
  require 'zip'
  require 'fileutils'
  
  before_action :set_recording, only: [:show, :edit, :update, :destroy]

  # GET /recordings
  # GET /recordings.json
  def index
    @recordings = Recording.all
  end

  # GET /recordings/1
  # GET /recordings/1.json
  def show

    
    #Fix this - currently only gets length from last start time to beginning
    @segments = Recording.find(params[:id]).segments.sort_by(&:start_time)
    gon.interview_segments = @segments.to_json
    gon.interview_length = @segments.sort_by{|s| s.end_time.to_i}.last.end_time
    
  end

  # GET /recordings/new
  def new
    @recording = Recording.new
  end

  def upload_tags
    @recording = params[:id]
  end
  
  def process_tags
    @recording = Recording.find(params[:id])
    uploaded_zip = params[:file].tempfile
    puts uploaded_zip
    ## Open uploaded zip and process - module in /lib/node_import.rb
    ## Saves everything as well
    # unpack_and_process_zip(uploaded_zip)
    
    ### Convert segment times to seconds
    convert_segment_times(@recording)
    
    redirect_to @recording
    
  end

  # GET /recordings/1/edit
  def edit
  end

  # POST /recordings
  # POST /recordings.json
  def create
    @recording = Recording.new(recording_params)

    respond_to do |format|
      if @recording.save
        format.html { redirect_to @recording, notice: 'Recording was successfully created.' }
        format.json { render :show, status: :created, location: @recording }
      else
        format.html { render :new }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordings/1
  # PATCH/PUT /recordings/1.json
  def update
    respond_to do |format|
      if @recording.update(recording_params)
        format.html { redirect_to @recording, notice: 'Recording was successfully updated.' }
        format.json { render :show, status: :ok, location: @recording }
      else
        format.html { render :edit }
        format.json { render json: @recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordings/1
  # DELETE /recordings/1.json
  def destroy
    @recording.destroy
    respond_to do |format|
      format.html { redirect_to recordings_url, notice: 'Recording was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_params
      params[:recording].permit(:file, :bio_text, :name, :job_title, :job_description, :author_id)
    end
end
