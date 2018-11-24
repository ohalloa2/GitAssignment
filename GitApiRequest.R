#install.packages("jsonlite")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")
# Change based on what your application is


# Change based on what you 
myapp <- oauth_app(appname = "GitAssignment",
                   key = "03cc3622ad0b4d8da559",
                   secret = "efcf9c80d35666e9ed2e4a080cfc022754990488")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]
#Above code sourced from https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08

#******************************************************************************************************************************#

#Interrogating the GitAPI 
#**************************#

#The information about my github profile is 
#stored in a data frame called 'myData'.  I can access different parts of the data 
#frame using the $ operator, shown below.

mydata=fromJSON("https://api.github.com/users/ohalloa2")
mydata$email #null return 
mydata$name #Null return 
mydata$login
mydata$id
mydata$followers #Give the number of people who follow my profile
mydata$following

#Accessing information about my followers 
#myFollowers = fromJSON("https://api.github.com/users/ohalloa2/followers") #Specific link to find details about my followers 
#myFollowers$login #Gives details of the usernames of all users who follow me
#myFollowers$type
myFollowers$starred_url
myFollowers$url

#Accessing information about the users I am following 
usersImFollowing = fromJSON("https://api.github.com/users/ohalloa2/following") 
usersImFollowing$login #Gives details of the usernames of all the people I follow 
usersImFollowing$type #Details of the types of people I follow , everyone I follow is of type user 
usersImFollowing$followers_url #this will give me the urls for later when I'm finding other users information 
#**sample output: "https://api.github.com/users/toconno5/followers"  - used later in code 
usersImFollowing$site_admin #Gives true/False details of whether the people I am following are admins or not, no one I am following is a site administrator 

#Accessing repository specific information 
repos=fromJSON("https://api.github.com/users/ohalloa2/repos") #Specific link to find details about my different repositories 
repos$name #Details of the names of my public repositories
repos$created_at #Gives details of the date the repositories were created 
repos$private #outlines whether my repositories are private or not 
repos$language #Displays the languages of the different repositories 
myLanguages = repos$language
aggregate(data.frame(count = myLanguages), list(value =myLanguages), length) #Data frame displaying count for each language 

#Not sure what this is currently doing
df_uniq = unique(myLanguages)
length(df_uniq)

lcaRepos <- fromJSON("https://api.github.com/repos/ohalloa2/CS3012_LCA/commits")
lcaRepos$commit$message #The details I included describing each commit to LCA assignment repository 

#Can repeat the process above for other users to gether information about their profiles 
#Do this by changing the user name in the link
jennybcData = fromJSON("https://api.github.com/users/jennybc") #Data frame which holds toconno5's information 
jennybcData$followers #Displays number of followers
jennybcData$public_repos #Displays number of public repositories 

jennybcFollowing= fromJSON("https://api.github.com/users/jennybc/following")
jennybcFollowing$login #names of all users that are following jennybc
jennybcFollowing$url

#Accessing information of starred items by phadej
starred = fromJSON("https://api.github.com/users/octocat/starred")
starred$name

#######
#install.packages("devtools")
#install.packages("Rcpp")
library(devtools)
library(Rcpp)
#install_github('ramnathv/rCharts', force= TRUE)
require(rCharts)

myDataJSon <- toJSON(myData, pretty = TRUE)
myDataJSon

#Step 2: Accessing information and displaying the number of followers that my followers have 

followersNames <- fromJSON("https://api.github.com/users/ohalloa2/followers")
followersNames$login #shown previously, gets the user names of my followers

a <- "https://api.github.com/users/"
b <- followersNames$login[4]
b
c <- "/followers"

test <- sprintf("%s%s%s", a,b,c) 
test                              #called test 

#Step 2:

numOfFollowers <- c() 
namesOfFollowers <- c()
for (i in 1:length(followersNames$login)) {
  followers <- followersNames$login[i] 
  jsonLink <- sprintf("%s%s%s", a, followers, c)
  followData <- fromJSON(jsonLink)
  numOfFollowers[i] = length(followData$login) 
  namesOfFollowers[i] = followers 
  
}
numOfFollowers
namesOfFollowers
finalData <- data.frame(numOfFollowers, namesOfFollowers) #stores two vectors as one

#data frame
finalData$namesOfFollowers
finalData$numOfFollowers

#Step3: Visualize 

myPlot <- nPlot(numOfFollowers ~ namesOfFollowers, data = finalData, type = "multiBarChart")
myPlot #prints out the D3.JS interactive graph of how many followers my followers have

#Fixing error in push??
