#' Standardize Values Within a Vector
#'
#' This function standardizes the values within a vector. It processes each value by applying a standardization function, and can convert the values to lowercase if specified.
#'
#' @param values The vector of values to be standardized.
#' @param lowercase If TRUE, the standardized values will be converted to lowercase. Default is TRUE.
#'
#' @return A vector of standardized values.
#'
#' @examples
#' values <- c("Hello", "World", "FOO", "Bar Chart")
#' standardize_vector(values, lowercase = TRUE)
#'
#' @export

standardize_vector <- function(values, lowercase = TRUE) {

  values <- unlist(values)
  values_new <- NULL
  for (current_value in values) {
    values_new <- c(values_new, standardize(current_value, lowercase))
  }
  # Return the output
  return(values_new)

}
