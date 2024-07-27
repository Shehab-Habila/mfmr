#' Apply Unity Table to Standardize Categories
#'
#' This function applies a unity table to a specified column in a data frame, uniting all variations of a value into a single standardized value.
#'
#' @param unity_table A data frame created by `make_unity_table` containing the standardized values and their variations.
#' @param table The data frame containing the column to be standardized.
#' @param column The name of the column in `table` to be standardized.
#'
#' @return The input data frame with the specified column standardized according to the unity table.
#'
#' @examples
#' df <- data.frame(ID = 1:6, Status = c("single", "Single", "SINGLE", "married", "Married", "MARRIED"))
#' unity_table <- make_unity_table(df, "Status", char_range = 1)
#' df_standardized <- apply_unity_table(unity_table, df, "Status")
#' print(df_standardized)
#'
#' @export

apply_unity_table <- function(unity_table, table, column) {

  # Doing some validations
  if ( !is.data.frame(unity_table) ) {
    stop("Variable 'table' must be a dataframe!")
  }
  if ( !is.data.frame(table) ) {
    stop("Variable 'table' must be a dataframe!")
  }
  if ( !(column %in% unlist(colnames(table))) ) {
    stop("This column name is not present within 'table' columns!")
  }

  # Reading the unity table
  united_values      <- as.vector(unity_table$value)
  values_variations  <- as.vector(unity_table$variations)

  # Starting the process
  for ( united_values_counter in 1:length(united_values) ) { # A loop to check every value in the column

    current_united_value  <- united_values[united_values_counter]
    current_variations    <- as.vector(unlist(values_variations[united_values_counter]))

    # Perform the replacements
    table <- unite_within_columns(table, column, current_variations, current_united_value, fuzzy = FALSE)

  }

  # Return the output
  return(table)

}
