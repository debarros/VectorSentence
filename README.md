# VectorSentence
This is a simple function that will convert a subset of a vector into an English language style comma separated string.

The two arguments are **x** and **y**
* x is an ordered vector of elements.
* y is a logical vector of the same length, indicating whether each element of x is to be used

VectorSentence(x,y) returns a string written the way one might in English, with 

1. commas separating elements 
1. the word "and" before the final element
1. consecutive elements of x abbreviated using a hyphen (like 5-8 for 5,6,7,8)

Note that the consecutive elements of x don't necessarily need to be naturally consecutive, like letters in alphabetical order.  The simple fact that they are consecutive within x is sufficient for VectorSentence to consider them consecutive.
