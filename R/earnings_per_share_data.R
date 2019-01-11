#' Create a data frame of a company's earnings per share.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param form_type "10-K" or "10-Q".
#' @param filing_order "0" for most recent statement, "1" for prior statement, "2" for next oldest statement, etc.
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's earnings per share.
#'
#' @export

earnings_per_share_data <- function(ticker, form_type, filing_order, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "earningspershare?formType=", sep = "/")
  url <- paste(url, form_type, sep = "")
  url <- paste(url, "&filingOrder=", filing_order, sep = "")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  eps <- map_df(data_url$Data, extract) %>%
    mutate(company = data_url$Company, statement = data_url$Name, source = data_url$Source) %>%
    gather()
  return(eps)
}
