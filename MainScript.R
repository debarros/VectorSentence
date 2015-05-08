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

  #Manipulate the data

x1 = 1:length(x)
x2 = x1[y]
x3 = c(x2[1],head(x2,-1)) #make a vector of the elemens of x2, shifted forward by 1 space


start = which(!(x2 == x3 +1)) ##find the elements s.t. the prior element comes right before it
end = data.frame(end = c(tail(start,-1)-1,length(x2))) ##find the last elements in consecutive runs
elements = cbind(start, end) #make them into a data frame

#At this point, I need to use the start and end of elements to find the relevant values of x2

elements$startIndex = x2[elements$start]
elements$endIndex = x2[elements$end]
elements$startValue = x[elements$startIndex]
elements$endValue = x[elements$endIndex]

elements$type = NA

elements$type[which(elements$start == elements$end)] = elements$startValue[which(elements$start == elements$end)]
elements$type[which(elements$start == elements$end - 1)] = paste0(elements$startValue[which(elements$start == elements$end - 1)],", ",elements$endValue[which(elements$start == elements$end - 1)])
elements$type[which(is.na(elements$type))] = paste0(elements$startValue[which(is.na(elements$type))],"-",elements$endValue[which(is.na(elements$type))])


paste0(c(elements$type[1:(nrow(elements)-1)], paste0("and ", tail(elements$type,1))), collapse = ", ")
}


#Th following is sample data that can be used to test out the function
#x = c(as.character(1:4), "5a", "5b", as.character(6:40), "D1", "D2", "D3a", "D4a", "D5", "D6", "Essay", letters[5:20]) #some vector
#y = sample(c(T, F), size = length(x), replace = TRUE) #elements to use
#if (sum(y) < length(y)/2){
#  y = !y
#}
#VectorSentence(x,y)