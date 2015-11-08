# VectorSentence
# by Paul de Barros

# This functions creates a string that lists the selected elements of a vector
# The elements will be separated by commas, including the Oxford comma
# If there are runs of consecutive elements selected, they will be grouped using hyphenation
# Hyphenation refers to abbreviating a run of consecutive elements by using just the first and last, separated by a hyphen

# The functions takes 4 arguments
# x - a vector of values, some subset of which are to be listed in the ouput string
# y - a logical vector of the same length as x, indicating whether each element should be included
# Style - a character, either Oxford, NonOxford, or NoAnd.
#         Oxford - use the oxford comma
#         NonOxford - don't use the oxford comma
#         NoAnd - don't insert the word "and" before the last item

# The output of this function is a string

VectorSentence = function(x, y, OxfordComma = T, End = "and ", hyphenate = 3){
  
  #Create the variables that that will be used later in the function  
  x1 = 1:length(x)          #create a vector of the indices of the values
  x2 = x1[y]                #create a vector of just the indices of the values that will be included in the output
  x3 = c(x2[1],head(x2,-1)) #make a vector of the elements of x2, shifted forward by 1 space
  
  #create a data.frame to be used in building the sentence
  start = which(!(x2 == x3 +1))                          #find the elements s.t. the prior element comes right before it
  end = data.frame(end = c(tail(start,-1)-1,length(x2))) #find the last elements in consecutive runs
  elements = cbind(start, end)                           #make them into a data frame
  
  #Currently, the elements data.frame holds only the indices of the indices of x2
  #Add columns to get the corresponding values of x2
  elements$startIndex = x2[elements$start]
  elements$endIndex = x2[elements$end]
  
  #Now the elements data.frame has the values of x2
  #However, those are just the subset of x1 to be used, and x1 is just the indices of x
  #Add columns to get the values from x
  elements$startValue = x[elements$startIndex]
  elements$endValue = x[elements$endIndex]
  
  #Add new variables to hold each entry in the comma separated string, and to hold the type of entry
  elements[,c("type", "entry")] = NA
  
  #Determine the types
  elements$type[elements$start == elements$end] = "single"
  elements$type[elements$start < elements$end] = "comma"
  if(hyphenate > 1){elements$type[(elements$start - 1) <= (elements$end - hyphenate)] = "hyphenate"}
  
  #Create the entry list
  Entries = list()
  
  for (i in 1:nrow(elements)){
    if(elements$type[i] == "single"){Entries[[i]] = elements$startValue[i]
    } else if(elements$type[i] == "comma"){Entries[[i]] = x[seq.int(elements$startIndex[i],elements$endIndex[i])]
    } else {Entries[[i]] = paste0(elements$startValue[i],"-",elements$endValue[i])}
  }
  
  Entries = unlist(Entries)
  
  if(OxfordComma){End = paste0(", ",End)}else{End = paste0(" ",End)}
  
  #Return the comma separated string, completely assembled
  paste0(paste0(Entries[1:(length(Entries)-1)],collapse = ", "),End,Entries[length(Entries)])
  
  
} #end of function
