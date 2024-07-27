#' Automatically Unite Variations within a Column
#'
#' This function automatically identifies and unites variations of values within a specified column in a data frame. It uses `make_unity_table` to create a unity table and `apply_unity_table` to standardize the column based on the unity table.
#'
#' @param table The data frame containing the column to be standardized.
#' @param column The name of the column in `table` to be standardized.
#'
#' @return The input data frame with the specified column contents standardized and unified.
#'
#' @examples
#' df <- data.frame(ID = 1:6, Status = c("single", "Single", "SINGLE", "married", "Married", "MARRIED"))
#' df_standardized <- auto_unite_column(df, "Status")
#' print(df_standardized)
#'
#' @export

auto_unite_column <- function(table, column) {

  # Doing some validations
  if ( !is.data.frame(table) ) {
    stop("Variable 'table' must be a dataframe!")
  }
  if ( !(column %in% unlist(colnames(table))) ) {
    stop("This column name is not present within 'table' columns!")
  }

  # The actual process
  table <- apply_unity_table(make_unity_table(table, column), table, column)

  # Return the output
  return(table)

}
