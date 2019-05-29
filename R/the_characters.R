#' Summarize the Characters
#'
#' This function provides a brief overview of the character columns in the supplied dataframe. With this function, you can easily discover the number of missing values and the number of unique values.
#'
#' @param df `dataframe` or `tibble`
#'
#' @return `tibble`, tibble of summary
#' @export
#'
#' @importFrom magrittr "%>%"
#'
#' @examples
#' # the_characters(iris)
the_characters <- function(df) {
  # let's get the character columns only
  dfb <- df %>%
    dplyr::select_if(function(col) is.character(col) | all(is.factor(col)))

  # get the variable type
  dfb_type <- dfb %>%
    purrr::map_df(function(x) class(x)) %>%
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
