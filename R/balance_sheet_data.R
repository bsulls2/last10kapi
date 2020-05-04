#' Create a data frame of a company's balance sheet.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param form_type "10-K" or "10-Q".
#' @param filing_order "0" for most recent statement, "1" for prior statement, "2" for next oldest statement, etc.
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return A data frame of the chosen company's balance sheet line items.
#'
#' @import tidyverse
#' @import magrittr
#' @import httr
#' @import XML
#'
#' @export

balance_sheet_data <- function(ticker, form_type, filing_order, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker,
               "balancesheet?formType=", sep = "/")
  url <- paste(url, form_type, sep = "")
  url <- paste(url, "&filingOrder=", filing_order, sep = "")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  bs <- map_df(data_url$data$attributes$result, extract) %>%
    mutate(company = data_url$data$attributes$company$name,
           statement = data_url$data$attributes$filing$name,
           source = data_url$data$attributes$filing$source) %>%
    gather()
  return(bs)
}
