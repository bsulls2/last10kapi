#' Create a data frame of a company's recent liabilities.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param form_type "10-K" or "10-Q".
#' @param filing_order "0" for most recent statement, "1" for prior statement, "2" for next oldest statement, etc.
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's recent liabilities from past transactions or events.
#'
#' @export

liabilities_data <- function(ticker, form_type, filing_order, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, "liabilities?formType=", sep = "/")
  url <- paste(url, form_type, sep = "")
  url <- paste(url, "&filingOrder=", filing_order, sep = "")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  liabilities <- map_df(data_url$Data, extract) %>%
    mutate(company = data_url$Company, statement = data_url$Name, source = data_url$Source) %>%
    gather()
  return(liabilities)
}
