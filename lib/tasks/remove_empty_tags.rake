###
desc 'remove tags'
task :remove_empty_tags => :environment do
  
  @recordings = Recording.all
  
  @recordings.each do |r|
    ### get a list of tags that are in the tags list but not in the segments
    puts "looking at #{r.name}"
    difftags = r.tags.map{|t| t.name}.uniq.reject{|tt| r.segments.map{|s| s.name}.include? tt }
    if difftags != []
      tag_ids = r.tags.where(name: difftags).map{|t| t.id}
      ### Destroy the taggings
      Tagging.where(tag_id: tag_ids, taggable_id: r.id).destroy_all
      puts "destroyed #{tag_ids.count} taggings for this recording"
    else
      puts "nothing found!"
    end
    r.save
  end
  puts "*** ALL DONE ***"
end

task :remove_unused_tags => :environment do 
  #get list of all the recordings tag names
  @recordings = Recording.all
  r_tag_names = []
  @recordings.each do |r|
     r_tag_names += r.tags.map{|t| t.name}
     r_tag_names = r_tag_names.uniq
  end
  
  ### Get list of all the tag names
  all_t_names = Tag.all.map{|t| t.name}
  
  ### find the list of unused tags 
  unused_tags = all_t_names.reject{|t| r_tag_names.include? t}
  
  unless unused_tags.empty?
    ### remove the tag
    Tag.where(name: unused_tags).destroy_all
  end
  @recordings.each do |r|
    r.save
  end
  
end