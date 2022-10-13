library("httr")

endpoint <-
  oauth_endpoint(base_url = "https://api.genius.com/oauth",
                 authorize = "authorize",
                 access = "token")

app <- oauth_app("genius",
                 key = "YOUR_API_KEY",
                 secret = "YOUR_API_SECRET")

token <- oauth2.0_token(
  endpoint,
  app,
  scope = "me",
  as_header = TRUE,
  user_params = list(state = "", response_type = "code"),
  use_oob = FALSE
)

request <- GET("https://api.genius.com/search",
               query = list(q = "bladee"),
               config(token = token))
stop_for_status(request)
response <- jsonlite::fromJSON(content(request, "text"))
