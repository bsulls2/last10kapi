#' Create a data frame of a company's stock quote information.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's stock quote.
#'
#' @export

stock_quote <- function(ticker, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "quote", sep = "/")
  get_url <- GET(url, query = list(key = subscription_key))
  quote <- content(get_url, type = "application/json", as = "parsed") %>%
    discard(is.null) %>%
    map_df(extract) %>%
    gather()
  return(quote)
}
