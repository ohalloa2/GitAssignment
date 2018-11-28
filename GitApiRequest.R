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
1
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

myDataJSon <- toJSON(myData, pretty = TRUE)
myDataJSon

# #Step 2: Accessing information and displaying the number of followers that my followers have 

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
 
 #install.packages("devtools")
 #install.packages("Rcpp")
library(devtools)
library(Rcpp)
# #install_github('ramnathv/rCharts', force= TRUE)
require(rCharts)
 
 myPlot <- nPlot(numOfFollowers ~ namesOfFollowers, data = finalData, type = "multiBarChart")
 myPlot #prints out the D3.JS interactive graph of how many followers my followers have
 
 myPlot$save("myplot.html")
 
# #This runs on my laptop - 


###
#Another way of plotting graphs - done using plotly and extracting information in a different way 

#This way interroates another users information and puts there information in a data.frame 
#This plot will plot followers against number of repositories

#install.packages("plotly")
library(plotly)


#extracting jennybc information
userData = GET("https://api.github.com/users/jennybc/followers?per_page=100;", gtoken)
stop_for_status(userData)

extract = content(userData)

# Convert content to dataframe
githubDB = jsonlite::fromJSON(jsonlite::toJSON(extract))
githubDB$login
id = githubDB$login
user_ids = c(id)

# Creating an empty vector and data.frame
users = c()
usersDB = data.frame(
  username = integer(),
  following = integer(),
  followers = integer(),
  repos = integer(),
  dateCreated = integer()
)

#For loop to collect all the users 
for(i in 1:length(user_ids))
{
  followingURL = paste("https://api.github.com/users/", user_ids[i], "/following", sep = "")
  followingRequest = GET(followingURL, gtoken)
  followingContent = content(followingRequest)
  
  #If they have no followers move on
  if(length(followingContent) == 0)
  {
    next
  }
  
  followingDF = jsonlite::fromJSON(jsonlite::toJSON(followingContent))
  followingLogin = followingDF$login

  for (j in 1:length(followingLogin))
  {
    if (is.element(followingLogin[j], users) == FALSE)
    {
      users[length(users) + 1] = followingLogin[j]
      followingUrl2 = paste("https://api.github.com/users/", followingLogin[j], sep = "")
      following2 = GET(followingUrl2, gtoken)
      followingContent2 = content(following2)
      followingDF2 = jsonlite::fromJSON(jsonlite::toJSON(followingContent2))
      
   
      followingNumber = followingDF2$following
      followersNumber = followingDF2$followers
      reposNumber = followingDF2$public_repos
      yearCreated = substr(followingDF2$created_at, start = 1, stop = 4)
      
      #Puts users data to a new row in dataframe
      usersDB[nrow(usersDB) + 1, ] = c(followingLogin[j], followingNumber, followersNumber, reposNumber, yearCreated)
    }
    next
  }
  
  #Max is 400 users 
  if(length(users) > 400)
  {
    break
  }
  next
}

#Link R to my plotly account
#Creates online interactive graphs based on the d3js library
Sys.setenv("plotly_username"="ohalloa2")
Sys.setenv("plotly_api_key"="WnIn8ohwy1HD1GEiwuUu")

plot = plot_ly(data = usersDB, x = ~repos, y = ~followers, 
                text = ~paste("Followers: ", followers, "<br>Repositories: ", 
                              repos, "<br>Date Created:", dateCreated), color = ~dateCreated)
plot

#Upload the plot to Plotly
Sys.setenv("plotly_username"="ohalloa2")
Sys.setenv("plotly_api_key"="WnIn8ohwy1HD1GEiwuUu")
api_create(plot1, filename = "Followers vs Repositories by Date")
#PLOTLY LINK: https://plot.ly/~ohalloa2/1/#/

