#' Standardize the Column Names of a Given Table
#'
#' This function standardizes the column names of a given table so that other functions can work properly.
#' The standardization process can include converting column names to lowercase if specified.
#'
#' @param table The table whose columns will be standardized. Must be a data frame.
#' @param lowercase If TRUE, the column names will be converted to lowercase. Default is TRUE.
#'
#' @return The table with standardized column names.
#'
#' @examples
#' df <- data.frame("First Name." = c("Alice", "Bob"), "Age" = c(25, 30))
#' standardize_col_names(df, lowercase = TRUE)
#'
#' @export


standardize_col_names <- function(table, lowercase = TRUE) {

  # Doing some validations
  if ( !is.data.frame(table) ) {
    print("ERROR: table variables must be a dataframe!")
    return(table)
  }

  # Start the process
  colnames(table) <- standardize_vector(colnames(table))

  return(table)

}
