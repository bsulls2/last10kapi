#' Create a data frame of a company's historical stock prices.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's historical stock prices.
#'
#' @export

historical_stock_prices <- function(ticker, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "prices", sep = "/")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  hist_prices <- map_df(data_url$data$attributes$result, extract) %>%
    gather()
  return(hist_prices)
}
