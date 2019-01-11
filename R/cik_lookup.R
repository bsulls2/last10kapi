#' Look up a company's CIK.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's CIK.
#'
#' @export

cik_lookup <- function(ticker, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "cik", sep = "/")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  cik <- as_tibble(data_url)
  return(cik)
}
