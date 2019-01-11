#' Display a company's financial ratios.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A list of the chosen company's financial ratios.
#'
#' @export

fin_ratios <- function(ticker, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "ratios", sep = "/")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed") %>%
    keep(is_list)
  return(data_url)
}
