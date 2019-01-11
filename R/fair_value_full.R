#' Display all fair value measurements statement content from a company's filing.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param form_type "10-K" or "10-Q".
#' @param filing_order "0" for most recent statement, "1" for prior statement, "2" for next oldest statement, etc.
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return All fair value measurements statement content from this company's filing.
#'
#' @export

fair_value_full <- function(ticker, form_type, filing_order, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "fairvalue?formType=", sep = "/")
  url <- paste(url, form_type, sep = "")
  url <- paste(url, "&filingOrder=", filing_order, sep = "")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  return(readHTMLTable(data_url$Content))
}
