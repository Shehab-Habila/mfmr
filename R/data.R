#' Bill Dataset
#'
#' A dataset containing product IDs from a bill; You need to match each ID with its Name an Cost from match_vegetables, match_fruits, and match_missings.
#'
#' @format A data frame with the following column:
#' \describe{
#'   \item{Product ID}{A unique identifier for each vegetable product.}
#'   \item{Product Name}{The name of the vegetable product.}
#'   \item{Cost}{The cost of the vegetable product.}
#' }
#' @source Simulated data for practice with matching and standardize functions.
#' @examples
#' data(match_bill)
"match_bill"

#' Vegetable Products Dataset
#'
#' A dataset containing product IDs, names, and costs for vegetables; needs to be matched with match_bill.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{Product ID}{A unique identifier for each vegetable product.}
#'   \item{Product Name}{The name of the vegetable product.}
#'   \item{Cost}{The cost of the vegetable product.}
#' }
#' @source Simulated data for practice with matching and standardize functions.
#' @examples
#' data(match_vegetables)
"match_vegetables"

#' Fruit Products Dataset
#'
#' A dataset containing product IDs, names, and costs for fruits; needs to be matched with match_bill.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{Product ID}{A unique identifier for each fruit product.}
#'   \item{Product Name}{The name of the fruit product.}
#'   \item{Cost}{The cost of the fruit product.}
#' }
#' @source Simulated data for practice with matching and standardize functions.
#' @examples
#' data(match_fruits)
"match_fruits"

#' Missing Products Dataset
#'
#' A dataset containing product IDs, names, and costs for products missing from the vegetable and fruit datasets; needs to be matched with match_bill.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{Product ID}{A unique identifier for each missing product.}
#'   \item{Product Name}{The name of the missing product.}
#'   \item{Cost}{The cost of the missing product.}
#' }
#' @source Simulated data for practice with matching and standardize functions.
#' @examples
#' data(match_missings)
"match_missings"

#' Marital Status Dataset
#'
#' A dataset containing personal information written with some bad variation.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{ID}{A unique identifier for each individual.}
#'   \item{Marital Status}{The marital status of the individual, indicated as "married" or "single".}
#'   \item{Have a Job}{Indicates whether the individual has a job, answered with "yes" or "no".}
#'   \item{Financially Satisfied}{Indicates whether the individual is financially satisfied, answered with "yes" or "no".}
#' }
#' @source Simulated data for practicing unite functions.
#' @examples
#' data(clean_marital_status)
"clean_marital_status"
