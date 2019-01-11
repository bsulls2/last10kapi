#' Display a company's documentation and entity information.
#'
#' @description Enter function parameters in parentheses.
#'
#' @param ticker Company stock ticker, for example "AAPL".
#' @param form_type "10-K" or "10-Q".
#' @param filing_order "0" for most recent statement, "1" for prior statement, "2" for next oldest statement, etc.
#' @param subscription_key Your Last10k.com Primary key, in parentheses, shown under Your Subscriptions in your profile page.
#'
#' @return Data frame of documentation and entity information from this company's filing.
#'
#' @export

doc_entity_summary <- function(ticker, form_type, filing_order, subscription_key) {
  url <- paste("https://services.last10k.com/v1/company", ticker, sep = "/")
  url <- paste(url, "?formType=", form_type, sep = "")
  url <- paste(url, "&filingOrder=", filing_order, sep = "")
  get_url <- GET(url, query = list(key = subscription_key))
  data_url <- content(get_url, type = "application/json", as = "parsed")
  info <- as_tibble(data_url$Name) %>%
    mutate(cik = data_url$CIK, company = data_url$Company, accession_number = data_url$AccessionNumber, source = data_url$Source, filing_date = data_url$FilingDate, filing_count = data_url$FilingCount) %>%
    gather()
  return(info)
}
