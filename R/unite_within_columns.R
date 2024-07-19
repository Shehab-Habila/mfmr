#' Unite Variations of Strings Within Specific Columns in a Table
#'
#' This function unites all variations of specific strings within selected columns of a dataframe to avoid minor misspellings and ensure consistency for statistical analysis. Variations can be united using fuzzy matching if enabled.
#'
#' @param table The dataframe in which variations of strings will be united.
#' @param columns_names A vector of column names where the variations will be united.
#' @param target_values A vector of variations that will be united. If `fuzzy` is TRUE, you can provide a smaller set of variations as the function will use fuzzy matching to recognize similar strings.
#' @param unite_to The final standardized form to which all variations will be united.
#' @param fuzzy When TRUE, fuzzy matching is used to recognize variations. Default is TRUE.
#' @param char_range The maximum tolerated number of added or removed characters for fuzzy matching. Default is 1.
#'
#' @return The dataframe with variations of strings united in the specified columns according to the given parameters.
#'
#' @examples
#' # Sample dataframe
#' df <- data.frame(Name = c("Jonh Doe", "John Doe", "Jon Doe", "Jane Doe"),
#'                  Address = c("123 Main St", "124 Main St", "123 Main Steet", "125 Main St"))
#'
#' # Unite variations of "John Doe" and "Main Steet" into standardized forms
#' df_united <- unite_within_columns(df,
#'                                    columns_names = c("Name", "Address"),
#'                                    target_values = c("Jonh Doe", "John Doe", "Jon Doe"),
#'                                    unite_to = "John Doe",
#'                                    fuzzy = TRUE)
#'
#' @export

unite_within_columns <- function(table, columns_names, target_values, unite_to, fuzzy = TRUE, char_range = 1) {

  # Doing some validations
  if ( !is.logical(fuzzy) ) {
    print("ERROR: fuzzy variable must be a boolean!")
    return(table)
  }
  if ( !is.numeric(char_range) ) {
    print("ERROR: char_range must be number.")
    return(table)
  }
  if ( !is.data.frame(table) ) {
    print("ERROR: table variable must be a dataframe!")
    return(table)
  }
  if ( !is.vector(columns_names) ) {
    print("ERROR: columns_names variable must be a vector of columns names.")
    return(table)
  }
  if ( FALSE %in% (columns_names %in% unlist(colnames(table))) ) {
    print("ERROR: columns_names must all be among the columns names of table dataframe!")
    return(table)
  }
  if ( !is.vector(target_values) ) {
    print("ERROR: columns_names variable must be a vector of columns names.")
    return(table)
  }
  if ( length(unite_to) != 1 ) {
    print("ERROR: unite_to must be a string of one value!")
    return(table)
  }

  # Start the process
  for (current_column in columns_names) { # Loop to select each column
    column_length <- length(unlist(table[current_column]))
    for (counter in 1:column_length) { # In each column, there is a loop to select each cell
      current_value <- unlist(table[current_column])[counter]
      for (current_target in target_values) { # For each cell, there is a loop to compare its value with the targets
        if ( !is.null( match_string_to_string(current_value, current_target, fuzzy, char_range) ) ) {
          column_values <- unlist(table[current_column])
          column_values[counter] <- unite_to
          table[current_column] <- column_values
          break
        }
      }
    }
  }

  # Return the output
  return(table)

}
