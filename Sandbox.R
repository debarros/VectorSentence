#Sandbox

#Reset the data in the current environment ####
z = ls()
z = z[!(z %in% c("x", "y"))]
rm(list = z)
gc()
source("MainScript.R")




#Sample Data 1 ####
x = c(as.character(1:4), "5a", "5b", "5c", as.character(6:41), 
      "D1", "D2", "D3a", "D4a", "D5", "D6", "Essay", letters[5:20])
y = sample(c(T, F), size = length(x), replace = TRUE) #elements to use
if (sum(y) < length(y)/2){y = !y}  #make sure at least half of the elements are True
names(y) = x




#Test Run 1 ####
y #look at the stuff
VectorSentence(x,y) #basic call
VectorSentence(x,y, hyphenate = 4, End = "and also ") #change the minimum hyphenation and the final words
VectorSentence(x,y, hyphenate = 8, End = "and also ")
VectorSentence(x, y, OxfordComma = F, End = "and ", hyphenate = 2) #turn off the oxford comma and hyphenate pairs
VectorSentence(x, y, OxfordComma = T, End = "", hyphenate = 4) #eliminate the final words
VectorSentence(x, y, OxfordComma = F, End = "", hyphenate = 3) #no final words or oxford comma
VectorSentence(x, y, OxfordComma = T, End = "", hyphenate = 1) #no hyphenation at all





#Sample Data 2  ####
y =rep(sample(c(T, F), size = round(length(x)/2), replace = TRUE), each =2)
names(y) = x





#Test Run 2 ####
y
VectorSentence(x,y)
VectorSentence(x,y, hyphenate = 3, End = "and also ")
VectorSentence(x,y, hyphenate = 8, End = "and also ")
VectorSentence(x, y, OxfordComma = F, End = "and ", hyphenate = 2)
VectorSentence(x, y, OxfordComma = T, End = "", hyphenate = 4)
VectorSentence(x, y, OxfordComma = F, End = "", hyphenate = 3)
VectorSentence(x, y, OxfordComma = T, End = "", hyphenate = 1)


