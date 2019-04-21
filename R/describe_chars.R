#' Summarize the Non-Numeric Columns In A Dataframe
#'
#' @param df a `dataframe`
#'
#' @return
#' @export
#'
#' @importFrom magrittr "%>%"
#'
#' @examples
describe_chars <- function(df) {
  # let's get the character columns only
  dfb <- df %>%
    dplyr::select_if(function(col) is.character(col) | all(is.factor(col)))

  # get the variable type
  dfb_type <- dfb %>%
    purrr::map_df(function(x) typeof(x)) %>%
    tidyr::gather(key = 'variable', value = 'type')


  # get the unique values in character columns
  dfb_unique <- dfb %>%
    purrr::map_df(function(x) length(unique(x))) %>%
    tidyr::gather(key = 'variable', value = 'unique')

  # get the number missing in character columns
  dfb_missing <- dfb %>%
    purrr::map_df(function(x) sum(is.na(x))) %>%
    tidyr::gather(key = 'variable', value = 'missing')

  combo <- dfb_type %>%
    dplyr::inner_join(dfb_unique, by = 'variable') %>%
    dplyr::inner_join(dfb_missing, by = 'variable')

  combo
}
