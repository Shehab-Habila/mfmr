#' Unite Variations of Strings in a Table
#'
#' This function unites all variations of specific strings within a table to avoid minor misspellings and ensure consistency for statistical analysis. Variations can be united using fuzzy matching if enabled.
#'
#' @param table The dataframe in which variations of strings will be united.
#' @param target_values A vector of variations that will be united. If `fuzzy` is TRUE, you can provide a smaller set of variations as the function will use fuzzy matching to recognize similar strings.
#' @param unite_to The final standardized form to which all variations will be united.
#' @param fuzzy When TRUE, fuzzy matching is used to recognize variations. Default is TRUE.
#' @param char_range The maximum tolerated number of added or removed characters for fuzzy matching. Default is 1.
#'
#' @return The dataframe with variations of strings united according to the specified parameters.
#'
#' @examples
#' # Sample dataframe
#' df <- data.frame(Name = c("Jonh Doe", "John Doe", "Jon Doe", "Jane Doe"))
#'
#' # Unite variations of "John Doe" into a single form
#' df_united <- unite_values_in_table(df, c("Jonh Doe"), "John Doe", fuzzy = TRUE)
#'
#' @export

unite_values_in_table <- function(table, target_values, unite_to, fuzzy = TRUE, char_range = 1) {

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
  if ( !is.vector(target_values) ) {
    print("ERROR: columns_names variable must be a vector of columns names.")
    return(table)
  }
  if ( length(unite_to) != 1 ) {
    print("ERROR: unite_to must be a string of one value!")
    return(table)
  }

  # Start the process
  columns <- unlist(colnames(table))
  table   <- unite_within_columns(table, columns, target_values, unite_to, fuzzy, char_range)

  # Return the output
  return(table)

}

