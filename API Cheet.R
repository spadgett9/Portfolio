##### LIBRARIES

library(devtools)
devtools::install_github("hrbrmstr/shodan")
library(shodan)
library(twitteR) 
library(httr)
library(jsonlite)
library(dplyr)
library(lubridate)

##### API CONNECTION

## shodan
key <- shodan_api_key("0YZRZiTjiGCoFf8MuMMX69jQAdNQ4aEq")

## twitter
consumer_key <- "OvldKhTB6Lc82QT8eyBa4Seli"
consumer_secret <-"in6HqPppWb0Il4YxH7RqF4N8OH5tWHRO3Ln5SEkbQf3Af80Fjx"
access_token <- "1058369753377619969-B6nrrUSyqM6jx6ctVzrv6WhhzvEzW0"
access_secret <- "yPdOBU9YHA1rQxIBwqitEYsZD8Nd2HHV5wSmyPUqbzImu" 
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

## facebook
# Define keys
app_id = '1639191212891042'
app_secret = 'ff0b16dc8fa023a5271991b297e5f3b2'

# Define the app
fb_app <- httr::oauth_app(appname = "facebook",
                    key = app_id,
                    secret = app_secret)



# Get OAuth user access token
fb_token <- httr::oauth2.0_token(httr::oauth_endpoints("facebook"),
                           fb_app,
                           scope = 'public_profile',
                           type = "application/x-www-form-urlencoded",
                           cache = TRUE)

node <- '/oauth/access_token'
query_args <- list(client_id = app_id,
                   client_secret = app_secret,
                   grant_type = 'client_credentials',
                   redirect_uri = 'http://localhost:1410/')

# GET request to generate the token
response <- httr::GET('https://graph.facebook.com',
                path = node,
                query = query_args)

# Save the token to an object for use
app_access_token <- httr::content(response)$access_token


##### SEARCHING FOR DATA

tw = searchTwitter('@YourAnonNews', n = 25)
d = twListToDF(tw)



