module ApplicationHelper
  
  ### Randomize colours for bg
  def bg_colour_list(n, black=true, rows_split=false)
    
    ### include black int he list
    if black
      colours = ["bgblack", "bgblue", "bgpeach", "bgseafoam"]
    else
      colours = ["bgblue", "bgpeach", "bgseafoam"]
    end
    
    ### Grow colours until its bigger than the list
    if n > colours.count
      while colours.count < n
        colours = colours + colours
      end
      colours = colours[0..n-1]
    else
      colours[0..n]
    end
    
    ### Split it into rows of three
    if rows_split
      colour_rows = {}
      colours.each_slice(3).to_a.each_with_index do |c,i|
        colour_rows[i] = c
      end
      colours = colour_rows
    end
    
    return(colours)
  end
  
end
