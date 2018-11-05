install.packages("jsonlite")
library(jsonlite)
install.packages("httpuv")
library(httpuv)
install.packages("httr")
library(httr)

require(devtools)
install_github('rCharts', 'ramnathv')
library(rCharts)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

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

#I will store numerous differet details about my GitHub profile in a data frame called 'myInfo'. 
#I will access different parts of the data frame using the $ operator

myData = fromJSON("https://api.github.com/users/ohalloa2") #Data frame which holds my information 
myData$followers #Displays number of followers i have
myData$public_repos #Displays number of public repositories i have


#Accessing information about my followers 
myFollowers = fromJSON("https://api.github.com/users/ohalloa2/followers") #Specific link to find details about my followers 
myFollowers$login #Gives details of the usernames of all users who follow me
noFollowers = length(myFollowers$login) #Give the number of people who follow my profile
noFollowers

#Accessing repository specific information 
repos=fromJSON("https://api.github.com/users/ohalloa2/repos") #Specific link to find details about my different repositories 
repos$name #Details of the names of my public repositories
repositories$created_at #Gives details of the date the repositories were created 

lcaRepos <- fromJSON("https://api.github.com/repos/ohalloa2/CS3012_LCA/commits")
lcaRepos$commit$message #The details I included describing each commit to LCA assignment repository 


