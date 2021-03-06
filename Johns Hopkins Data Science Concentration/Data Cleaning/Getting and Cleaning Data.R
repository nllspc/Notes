############################# R and statistic ##################################
# John Hopkins University open course
# offerer: Coursera
################################################################################

##################### Getting and Cleaning Data ################################  
#
#----------------------------- Week 1 ---------------------------------------------------
## set path
setwd("c:\\")

## Checking for and creating directories
file.exists("")  
dir.create("")

if (!file.exists("data")){
  dir.create("data")
}


## Getting data form the internet
fileUrl <- "https://data.baltimorecity/gov/api/views/dz54-2aru/row.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "\\data\\cameras.csv", method = "curl")
list.files("")
dateDownloaded <- date()
dateDownloaded


##Reading local file
cameraData <- read.table("", header=TRUE, sep="," )
cameraData <- read.csv("")
head(cameraData)


## Read excel file
fileUrl <- "https://data.baltimorecity/gov/api/views/dz54-2aru/row.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "\\data\\cameras.xlsx", method = "curl")
list.files("")
dateDownloaded <- date()
dateDownloaded
install.package(xlsx)
library(xlsx)
cameraData <- read.xlsx("", sheetIndex=1, header=TRUE)
head(camerData)
# reading specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("". sheetIndex=1, colIndex=colIndex, 
                              rowIndex=rowIndex)
# 
write.xlsx()
read.xlsx()
library(XLConnect)


## Reading XML file
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
# Programatically extract parts of the file
xmlSApply(rootNode,xmlValue)
# Get the items on the menu and prices
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
xpathSApply(rootNode,"//calories", xmlValue)
# Extract content by attributes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams


## Reading JSON
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
jsonData$owner$id
# writing data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
# Convert back to JSON
iris2 <- fromJSON(myjson)
head(iris2)


## Using data.table package
library(data.table)
# Create data tables just like data frames
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DF
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DT
# see all the table content
tables()
# subsetting rows
DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]
DT[,c(2,3)] # cant work
# summarying data
DT[,list(mean(x),sum(z))]
DT[,table(y)]
# Adding new columns
DT[,w:=z^2]
DT
# Multiple operations
DT[,m:={tmp<-(x+z);log2(tmp+5)}]
DT
# plyr like operations
DT[,a:=x>0]
DT
DT[,b:=mean(x+w),by=a]
DT
# Special variables
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT
DT[, .N, by=x]
# keys
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
DT
setkey(DT, x)
DT['a']
# Joins
DT1 <- data.table(x=c('a','a','b','dt1'), y=1:4)
DT2 <- data.table(x=c('a','b','dt2'), z=5:7)
DT1; DT2
setkey(DT1,x); setkey(DT2,x)
merge(DT1, DT2)
# Fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))


#----------------------------- Week2 ------------------------------------------------------

## reading from MySQL
library(RMySQL)
# connecting and listing databases
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb. "show databases"); dbDisconnect(ucscDb)
# connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
# get dimensions of a specific table
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
result
# read from the table
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
# select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fecth(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10)
dbClearResult(query)
dim(affyMisSmall)
# Don't forget to close the connection
dbDisconnect(hg19)


## Reading HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created
# create groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5"."foo/foobaa")
h5ls("example.h5")
# write to groups
A = matrix(1:10, nr=5, nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0, by=0.1), dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
# Write a data set
df = data.frame(1L:5L, seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")
# Reading data
readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA
readB
readdf
# Writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")


## Reading data from WEB

# Getting data off webpages
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=TRUE)
xpathSApply(html."//title", xmlValue)
xpathSApply(html,"//td[@id='col-citedby']", xmlValue)

# GET from the httr package
library(httr)
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)

# Using handles
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg2 = GET(handle=google, path="search")


## Getting data from API: Twitter or Facebook 

# Accessing Twitter from R
library(httr)
myapp = oauth_app("twitter",
                  key="yourConsumeKeyHere", secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token="yourTokenHere",
                    token_secret="yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

# Converting the json object
library(jsonlite)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]
# check HTTR demo component on Github


## Reading from other sources
# Goole "data storage mechanism R package"

# reading pictures
library(jpeg)
library(readbitmap)
library(png)
library(EBImage)
# reading GIS data
library(rdgal)
library(rgeos)
library(raster)
# reading music data
library(tuneR)
library(seewave)


#----------------------------- Week 3 ------------------------------------------
# check http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf
## Subsetting and sorting

### quick review
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)]=NA
X
### subsetting
X[,1]
X[,"var1"]
X[1:2,"var2"]
X[(X$var1<=3 & X$var3>11),]
X[(X$var1<=3 | X$var3>15),]
X[which(X$var2>8),]
### sorting
sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var2, na.last=TRUE)
### Ordering
X[order(X$var1),]
X[order(X$var1,X$var2),]
### Ordering with plyr(Tools for splitting, applying and combining data)
library(plyr)
arrange(X,var1)
arrange(X, desc(var1))
### adding rows and columns
X$var4 <- rnorm(5)
X
Y <- cbind(X, var5=rnorm(5))
Y
### Check
# http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf

## Summarizing data

### Getting the data from the web
if(!file.exist("./data")){dir.creat("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destifile="./data/restaurants.csv",method="curl")
restData <- read.csv("./data/restaurants.csv")
### Look at a bit of the data
head(restData,n=3)
tail(restData,n=3)
### make summary
summary(reData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9),na.rm=TRUE)
### make table
table(restData$zipCode, useNA="ifany")
table(restData$councilDistrict,restData$zipCode)
### check for missing values
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
### Row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)
### Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]
### cross tabs
data(UCBAdmissions)
DF = as.data.fram(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt
### flat tables
warpbreak$replicate <- rep(1:9, len=54)
xt = xtabs(break ~., data=warpbreaks)
ftable(xt)
### size of a data set
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

## Creating New Variables

### Creating sequences
s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along=x)
### Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)
### Creating binary variables
restData$zipWrong = ifelse(restData$zip<0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode<0)
### Creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)
### Easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
### Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
### levels of factor variables
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)
### Using the mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

## Reshaping data

### Start with reshaping
library(reshape2)
head(mtcars)
### Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt)
tail(carMelt)
### Casting data frames
cylData <- dcast(carMelt, cyl~variable)
cylData
cylData <- dcast(carMelt, cyl~variable,mean)
cylData
### Averaging values
head(InsectSprays)
tapply(InsectSprays$count,InsectSprays$spray,sum)
### Another way - split
spIns = split(InsectSpray$count,InsectSpray$spray)
spIns
sprCount = lapply(spIns,sum)
### Another way - combine
unlist(sprCount)
sapply(spIns,sum)
### Another way - plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
### Creating a new vairable
sprySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)

## Merging Data

### Peer review data
if(!file.exists("./data")){dir.creat("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solution-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews,csv")
download.file(fileUrl2,destfile="./data/solutions,csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews)
head(solutions)
### Merging data
names(reviews)
names(solutions)
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)
### Default - merge all common column names
intersect(names(solutions)),names(reviews)
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)
### Using join in the plyr package
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)
### If you have multiple data frames
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3); dfList
arrange(join_all(dfList),id)


#----------------------------- Week 4 ------------------------------------------

## Editing text variables

### Fixing character vectors
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/row.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
names(cameraData)
tolower(names(camerData))
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]
### Quick aside - lists
mylist <- list(letters=c("A","b","c"), numbers=1:3, matrix(1:25,ncol=5))
head(mylist)
mylist[[1]]
mylist$letters
mylist[1]
### Fixing character vectors - sapply()
splitNames[[6]][1]
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)
### Peer review data
if(!file.exists("./data")){dir.creat("./data")}
fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solution-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews,csv")
download.file(fileUrl2,destfile="./data/solutions,csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
### Fixing character vectors - sub()
names(reviews)
sub("_","",names(reviews),)
### Fixing character vectors - gsub()
testName <- "this_is_a_test"
sub("_","",testName)
gsub("_","",testName,)
### Finding values - grep(), grepl()
grep("Alameda",cameraData$intersection)
table(grepl("Alameda",cameraData$intersection))
cameraData2 <- camerData[!grepl("Alameda",cameraData$intersection)]
grep("Alameda",cameraData$intersection,value=TRUE)
grep("JeffStreet",cameraData$intersection)
length(grep("JeffStreet",cameraData$intersection))
### More useful string functions
library(stringr)
nchar("Jeffrey Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffrey","Leek")
paste0("Jeffrey","Leek")
library(stringer)
str_trim("Jeff    ")

## Regular Expressions

###
###################### Reproducible Research ###################################

# ---------------------------- Week 1 ------------------------------------------

## Literate Programming
source("http://www.statistik.lmu.de/~leisch/Sweave")

# http://yihui.name/knitr/

## Golden Rule of Reprocucibility: Script Everything

library(knitr)
setwd("C:\\Users\\HuangJing\\Desktop")
knit2html("")
browseURL("")
knit2pdf("C:\\Users\\HuangJing\\Desktop\\try.Rmd")
library("tools")
texi2pdf("C:\\Users\\HuangJing\\Desktop\\try.Rmd")
Sys.getenv(c("PATH", "TEX"))