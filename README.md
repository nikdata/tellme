
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tellme

## Background

As I do exploratory data analysis, I often find myself wondering about a
variety of stats that both the `summary()` and the `glimpse()` functions
are unable to provide. For instance, I like to know the mean, median,
standared deviation, 5th percentile, 10th percentile, etc. While the
aforementioned functions do a good job of providing *some* insight, I
felt the need to develop a more powerful way of getting the summaries I
wanted.

Hence, the tellme package was born.

<!-- badges: start -->

<!-- badges: end -->

The goal of tellme is to provide a much better summary of the different
numeric and non-numeric columns of data. Often, I find that the
`summary()` or the `dplyr::glimpse()` functions are unable to provide a
comprehensive summary of the underlying data.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nikdata/tellme")
```

## Example 1: Summarizing Numerical Data

``` r
library(tellme)

tellme::the_numbers(iris)
#> # A tibble: 4 x 16
#>   variable type  missing unique   min   max  mean median  pct5 pct10 pct25
#>   <chr>    <chr>   <int>  <int> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 Sepal.L… doub…       0     35   4.3   7.9  5.84   5.8   4.6    4.8   5.1
#> 2 Sepal.W… doub…       0     23   2     4.4  3.06   3     2.34   2.5   2.8
#> 3 Petal.L… doub…       0     43   1     6.9  3.76   4.35  1.3    1.4   1.6
#> 4 Petal.W… doub…       0     22   0.1   2.5  1.20   1.3   0.2    0.2   0.3
#> # … with 5 more variables: pct75 <dbl>, pct90 <dbl>, pct95 <dbl>,
#> #   skew <dbl>, kurtosis <dbl>
```

## Example 2: Summarizing Non-Numerical Data

``` r
library(tellme)

tellme::the_characters(iris)
#> # A tibble: 1 x 4
#>   variable type   unique missing
#>   <chr>    <chr>   <int>   <int>
#> 1 Species  factor      3       0
```
