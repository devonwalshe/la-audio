# encoding: utf-8
## Node file importer
## Takes an uploaded zipfile of node information and parses them
## Folder structure inside the zip be seperated into /nodes/subnodes and /nodes/headnodes
## Files are saved locally then read

module NodeImport
  
  ## Convert segment start and end time to seconds delta from zero
  def convert_segment_times(recording)
    puts "converting segment times"
    @segments = recording.segments
    ### Check that they haven't already been converted
    if @segments.first.start_time.match(/\d+:\d+\.\d+/) != nil
      @last_segment_end = @segments.sort_by{|s| Time.strptime(s.end_time, "%M:%S.%N")}.last.end_time
      @duration = Time.strptime(@last_segment_end, "%M:%S.%N") - Time.strptime("00:00.0", "%M:%S.%N")
      @segments.each do |segment|
        segment_start_seconds = Time.strptime(segment.start_time, "%M:%S.%N") - Time.strptime("00:00.0", "%M:%S.%N")
        segment_end_seconds = Time.strptime(segment.end_time, "%M:%S.%N") - Time.strptime("00:00.0", "%M:%S.%N")

        segment.end_time = segment_end_seconds
        segment.start_time = segment_start_seconds
      
        segment.save
      end
    end
    puts "converting segment times successful"
  end
  
  ## Get the list of paths inside the directory
  def get_filepaths(target_dir)
    dirpaths = [target_dir + "/subnodes", target_dir + "/headnodes"]
    filepaths = []
    dirpaths.each do |dirpath|
      Dir[dirpath+"/*"].each do |filepath|
        filepaths << filepath
      end
    end
    return filepaths
  end

  ## parse file and read relevant information from it
  def get_node_from_file(filepath)
    head_nodes_file = File.open(filepath,"r:UTF-16LE:UTF-8"){ |file| file.readlines }
    lines_array = []
    head_nodes_file.each do | line, i |
      lines_array << line
    end
    
    # if /(\\)(.*)(\\)(.*)$/.match(head_nodes_file[0]) == nil
    #   node_type = "head"
    # else
    #   node_type = "child"
    # end
    
    ## get relevant nodes based on what type it is
    head_nodes_file[0] == nil ? node = nil : node = /(Name: )(.*)/.match(head_nodes_file[0])[2].strip()
  
    ## get file name and reference number from line 2
    head_nodes_file[2] == nil ? references = nil : references = /(§ )(\d)/.match(head_nodes_file[2])[2].to_i
    
    ## Get all references from in 3 line blocks
    ref_array = []
    
    
    ### get the segment times from each reference
    if references != nil
      references.times do |i|
        # ref = i+1
        seg_line = 6+(i*4)
        # puts head_nodes_file[seg_line]
        # puts /(\[)(\d+:\d+.\d)/.match(head_nodes_file[seg_line])[2])
        # puts seg_line
        start_time =  /(\[)(\d+:\d+.\d)/.match(head_nodes_file[seg_line])[2]
        end_time = /(\d+:\d+.\d)(\])/.match(head_nodes_file[seg_line])[1]
        ref_array << {"start_time": start_time, "end_time": end_time}
      end
    else
      ref_array = nil
    end
  
    return {"filename": /^(.+)\/([^\/]+)$/.match(filepath)[2], "node": node, "segments": ref_array}
    
  end
  
  ## Get all nodes from the supplied filepaths
  def get_nodes(filepaths)
    nodes = []
    filepaths.each do |filepath|
      node = get_node_from_file(filepath)
      if node["segments"] != nil
        nodes << node
      end
    end
    return nodes
  end

  def get_author(file)
    
  end

  ### Ties it all together and saves the relevant objects to the database
  def unpack_and_process_zip(zip_file)
    Zip::File.open(zip_file) do |zipfile|
      @zipfile = zipfile
      folder_name = Time.now.strftime('%Y_%m_%d-%H_%M_%S')
      destination_dir = Rails.root.to_s + "/tmp/uploads/zips/" + "#{folder_name}"

      # Save files in directory
      zipfile.each do |entry|
        if /^[^_].*\/.*\/.*\.txt/.match(entry.name) != nil
          puts "Extracting #{entry.name}"
          f_path = File.join(destination_dir, entry.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zipfile.extract(entry, f_path) unless File.exist?(f_path)
        end
      end
      
      # Get nodes from files
      target_dir = File.join(destination_dir, "nodes")
      filepaths = get_filepaths(target_dir)

      @nodes = get_nodes(filepaths)
      
      # Save nodes
      # @recording is already in scope from controller
      # @recording = Recording.find(params[:id])
      @nodes.each do |tag|
        @tag = Tag.new
        @tagging = Tagging.new
        
        ### Set up the tag
        @tag.name = tag[:node]
        @tag = Tag.where(:name => @tag.name).first_or_create

        ## Now do the tagging
        @tagging = Tagging.where(:taggable_id => @recording.id, :taggable_type => @recording.class.name, :tag_id => @tag.id).first_or_create
        
        ## Now do the segments
        if tag[:segments]
          @segments = tag[:segments]
          @segments.each do |segment|
              
            start_time = segment[:start_time]
            end_time = segment[:end_time]

            @segment = Segment.where(:recording_id => @recording.id, :start_time => start_time, :end_time => end_time, :name => @tag.name).first_or_create
          
            ## Tagging for segment
            @tagging = Tagging.where(:taggable_id=> @segment.id, :taggable_type=> @segment.class.name, :tag_id => @tag.id).first_or_create
          end
          
        end
      end
    end

    ### Now save the recording to ensure that its got cached tags
    @recording.save
    ### All done
  end
  
end