# Notes on OSOS Workshop

getwd()
dir() #see files in working directory
setwd("/Users/chiranjibipoudyal/Desktop/R-studio codes/OSOS")
#Setting working directory
getwd()

# Numeric vectors and Functions
vector <- c(2, 3, 6, 8) #vector created

#Variable types in R
#Integers cannot contain decimals
a<-2
a_integer <- as.integer(a) #convert a(a numeric variable) to an integer
class(a_integer) #shos that our new variable is an integer
class(a) #original a variable is numeric

#Characters are variables mode of text (strings)
course_name <- "Open Source for Open Science"
course_topic <- c("R introduction, calculation, variables") #makes character vector

number <- "5"
class(number)

vector_char <- as.character(vector) #converts numeric to character
new_vec <- c("text", 2, 1.2) #if there is one character in a vector, whole 
#vector will be considered as character

library(readxl)

#Setting up and understanding the data

#Vectors#
#Vectors must all be the same type

Vec1 = c(3,5,2,"text")
class(Vec1)

#Selecting Elements in a vector
Vec1[1]
class(Vec1[1])

#Lists#
ex_list = list(1, 2.1, "text")
#selecting elements in the list
ex_list[2]

#Length of list
length(ex_list)

#examine the contents of list
str(ex_list)

ex_biglist = list(a="testing", b=1:15,c=22)
length(ex_biglist)
str(ex_biglist)
ex_biglist$a
ex_biglist$b
ex_biglist$c

#Matrices
ex_mat = matrix(1:10, nrow=2, byrow=TRUE)
ex_mat2 = matrix(1:10, nrow=2) #Give the column differently
class(ex_mat)
#Print out whole matrix with the dimension of matrix
str(ex_mat)
#selecting one element
ex_mat[2,2]
#selecting entire row and column
ex_mat[2,]

#data structuring
ex_df2=data.frame (id=1:12, width=12:1)
class(ex_df2)
Exe_df2 = data.frame(id=1:12, flavors=rep(c("apple","banana",6)))

#Subsetting the dataframe
Exe_df2[1,2]
#selecting the column 1
Exe_df2[,1]

#Selecting specific data fram
justapples=Exe_df2[which(Exe_df2$flavors=="apple"),]
justbanans=Exe_df2[which(Exe_df2$flavors=="banana"),]
#OR
justbanans=subset(Exe_df2, flavors=="banana")

#Importing the data
setwd("/Users/chiranjibipoudyal/Desktop/R-studio codes/OSOS")
dir()

liz_csv = "data/LizardData.csv"
liz_df<-read.csv(liz_csv)
head(liz_df)
class(liz_df)
summary(liz_df)

#input a text file
liz_txt = "data/LizardData.txt"
liz_df_txt = read.csv(liz_txt, sep="\t")
head(liz_df_txt)

library(readxl)
liz_df_xl=read_xlsx("data/LizardData.xlsx")
tail(liz_df_xl)
class(liz_df_xl)
summary(liz_df_xl)

install.packages("dplyr")
library(dplyr)
#making sure that R uses the correct version of the function
dplyr::filter()


head(liz_df)
liz_df$Regen
liz_df[liz_df$Regen=="38/6",]
liz_df$Regen=recode(liz_df$Regen,"38/6" = "38")
liz_df$Regen=recode(liz_df$Regen,"No" = "", "Yes"="")
liz_df$Regen

#column is still a character
class(liz_df$Regen)

#change to numeric
liz_df$Regen = as.numeric(liz_df$Regen)
class(liz_df$Regen)

#run functions on data frame elements
mean(liz_df$Regen)
mean(liz_df$Regen, na.rm=TRUE)
mean(liz_df$SVL)
mean(liz_df$SVL, na.rm=TRUE)

head(liz_df$SVL)
head(liz_df)


#Next session
set.seed(1)
help(rnorm)
x= rnorm(100, mean = 10, sd= 2)
x

#summary statistics
mean(x)
summary(x)
hist(x)
plot(x)

#test for normality
shapiro.test(x) #Data is normal as it is not significantly distributed

#set different seed
set.seed(5)
y = rnorm(100, mean=11, sd=2)
hist(y)
plot(y)
shapiro.test(y)

hist(x=x, col="blue", breaks=20)
hist(x=x, col="red", breaks=22)
hist(x=y, col="red", breaks=22)
hist(x=y, col="red", breaks=22, add=TRUE)

##Independent samples
#T-Test (parametric)
