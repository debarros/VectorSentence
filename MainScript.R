# VectorSentence
# by Paul de Barros

# This functions creates a string that lists the selected elements of a vector
# The elements will be separated by commas, including the Oxford comma
# If there are runs of consecutive elements selected, they will be grouped using hyphenation
# Hyphenation refers to abbreviating a run of consecutive elements by using just the first and last, separated by a hyphen

# The functions takes 2 arguments
# x - a vector of values, some subset of which are to be listed in the ouput string
# y - a logical vector of the same length as x, indicating whether each element should be included

# The output of this function is a string

VectorSentence = function(x, y){
  
  #Create the manipulated that that will be used later in the function  
  x1 = 1:length(x) #create a vector of the indices of the values
  x2 = x1[y] #create a vector of just the indices of the values that will be included in the output
  x3 = c(x2[1],head(x2,-1)) #make a vector of the elements of x2, shifted forward by 1 space
  
  #create a data.frame to be used in building the sentence
  start = which(!(x2 == x3 +1)) ##find the elements s.t. the prior element comes right before it
  end = data.frame(end = c(tail(start,-1)-1,length(x2))) ##find the last elements in consecutive runs
  elements = cbind(start, end) #make them into a data frame
  
  #Currently, the elements data.frame holds only the indices of the indices of x2
  #Add columns to get the corresponding values of x2
  elements$startIndex = x2[elements$start]
  elements$endIndex = x2[elements$end]
  
  #Now the elements data.frame has the values of x2
  #However, those are just the subset of x1 to be used, and x1 is just the indices of x
  #Add columns to get the values from x
  elements$startValue = x[elements$startIndex]
  elements$endValue = x[elements$endIndex]
  
  #Add a new variable to hold each entry in the comma separated string
  elements$entry = NA
  
  
  #Fill the entry column with the entries.  This section will expand when additional parameters are added
  
  #Create the entries for singleton items (nothing consecutive)
  elements$entry[which(elements$start == elements$end)] = elements$startValue[which(elements$start == elements$end)]
  
  #Create the entries for pairs (two consecutive, so don't use hyphen)
  elements$entry[which(elements$start == elements$end - 1)] = paste0(elements$startValue[which(elements$start == elements$end - 1)],", ",elements$endValue[which(elements$start == elements$end - 1)])
  
  #Create the hyphenated entries
  elements$entry[which(is.na(elements$entry))] = paste0(elements$startValue[which(is.na(elements$entry))],"-",elements$endValue[which(is.na(elements$entry))])
  
  
  #Return the comma separated string, completely assembled
  paste0(
    c(
      elements$entry[1:(nrow(elements)-1)], 
      paste0("and ", tail(elements$entry,1))
    ), 
    collapse = ", "
  )
} #end of function


#The following is sample data that can be used to test out the function
#x = c(as.character(1:4), "5a", "5b", as.character(6:40), "D1", "D2", "D3a", "D4a", "D5", "D6", "Essay", letters[5:20]) #some vector
#y = sample(c(T, F), size = length(x), replace = TRUE) #elements to use
#if (sum(y) < length(y)/2){
#  y = !y
#}
#VectorSentence(x,y)