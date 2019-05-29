#' Summarize the numeric values
#'
#' This function is designed to provide a deeper insight into the numerical values. Think of this function as the base `summary` function on high-power. With this function, you'll be able to get the min, max, median, and different quartiles in one go.
#'
#' @param df `dataframe` or `tibble`
#'
#' @return `tibble`, tibble of summary
#' @export
#'
#' @importFrom magrittr "%>%"
#'
#' @examples
#' the_numbers(iris)
the_numbers <- function(df) {

  # let's get the numeric columns only
  dfa <- df %>%
    dplyr::select_if(function(col) is.numeric(col))

  # get the means
  dfa_avg <- dfa %>%
    purrr::map_df(function(x) mean(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable',value = 'mean')

  # get the variable type
  dfa_type <- dfa %>%
    purrr::map_df(function(x) typeof(x)) %>%
    tidyr::gather(key = 'variable', value = 'type')

  # get the median
  dfa_median <- dfa %>%
    purrr::map_df(function(x) stats::median(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable',value = 'median')

  # get the min
  dfa_min <- dfa %>%
    purrr::map_df(function(x) min(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable',value = 'min')

  # get the max
  dfa_max <- dfa %>%
    purrr::map_df(function(x) max(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable',value = 'max')

  # get the 5 percentile
  dfa_5pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.05)) %>%
    tidyr::gather(key = 'variable',value = 'pct5')

  # get the 10 percentile
  dfa_10pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.10)) %>%
    tidyr::gather(key = 'variable',value = 'pct10')

  # get the 25 percentile
  dfa_25pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.25)) %>%
    tidyr::gather(key = 'variable',value = 'pct25')

  # get the 75 percentile
  dfa_75pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.75)) %>%
    tidyr::gather(key = 'variable',value = 'pct75')

  # get the 90 percentile
  dfa_90pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.90)) %>%
    tidyr::gather(key = 'variable',value = 'pct90')

  # get the 95 percentile
  dfa_95pct <- dfa %>%
    purrr::map_df(function(x) stats::quantile(x, na.rm = T, probs = 0.95)) %>%
    tidyr::gather(key = 'variable',value = 'pct95')

  # number of missing values
  dfa_missing <- dfa %>%
    purrr::map_df(function(x) sum(is.na(x))) %>%
    tidyr::gather(key = 'variable', value = 'missing')

  # number of unique values
  dfa_unique <- dfa %>%
    purrr::map_df(function(x) length(unique(x))) %>%
    tidyr::gather(key = 'variable', value = 'unique')

  # get skewness & kurtosis
  dfa_skew <- dfa %>%
    purrr::map_df(function(x) moments::skewness(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable', value = 'skew')

  dfa_kurtosis <- dfa %>%
    purrr::map_df(function(x) moments::kurtosis(x, na.rm = T)) %>%
    tidyr::gather(key = 'variable', value = 'kurtosis')

  # combine into one
  combo <- dfa_type %>%
    dplyr::inner_join(dfa_missing, by = 'variable') %>%
    dplyr::inner_join(dfa_unique, by = 'variable') %>%
    dplyr::inner_join(dfa_min, by = 'variable') %>%
    dplyr::inner_join(dfa_max, by = 'variable') %>%
    dplyr::inner_join(dfa_avg, by = 'variable') %>%
    dplyr::inner_join(dfa_median, by = 'variable') %>%
    dplyr::inner_join(dfa_5pct, by = 'variable') %>%
    dplyr::inner_join(dfa_10pct, by = 'variable') %>%
    dplyr::inner_join(dfa_25pct, by = 'variable') %>%
    dplyr::inner_join(dfa_75pct, by = 'variable') %>%
    dplyr::inner_join(dfa_90pct, by = 'variable') %>%
    dplyr::inner_join(dfa_95pct, by = 'variable') %>%
    dplyr::inner_join(dfa_skew, by = 'variable') %>%
    dplyr::inner_join(dfa_kurtosis, by = 'variable')

  combo
}
