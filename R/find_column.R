#' Search for a Wanted Column in a Set of Tables
#'
#' This function searches for a specified column name within a list of dataframes.
#' It provides an option for fuzzy matching, allowing for minor differences between
#' the specified column name and the actual column names in the dataframes.
#'
#' @param search_in A list of dataframes in which to search for the specified column name.
#' @param search_for A character string representing the name of the column to search for.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is TRUE.
#'
#' @return A dataframe with the indices of the tables, the indices of the matched columns within the tables, and the matched column names. Returns NULL if no matches are found.
#'
#' @examples
#' df3 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
#' df4 <- data.frame(Name = c("Carol", "David"), Salary = c(50000, 60000))
#' search_list2 <- list(df3, df4)
#' find_column(search_list2, "name")
#' find_column(search_list2, "salary", fuzzy = TRUE)
#'
#' @export

# search_in must be a list of dataframes # DONE
find_column <- function(search_in, search_for, fuzzy = TRUE) {

  # Doing some validations
  if ( !is.list(search_in) ) {
    print("ERROR: search_in variables must be a list of dataframes!")
    return(NULL)
  }
  for ( table in search_in ) {
    if ( !is.data.frame(table) ) {
      print("ERROR: search_in variables must be a list of dataframes!")
      return(NULL)
    }
  }
  if ( length(search_for) != 1 ) {
    print("ERROR: search_for must be a variable of one value!")
    return(NULL)
  }

  # Set the default outputs
  tables_matched  <- NULL
  indices_matched <- NULL
  columns_names   <- NULL

  # Start the search
  for ( table_counter in 1:length(search_in) ) {
    current_table <- search_in[table_counter]
    columns <- colnames(as.data.frame(current_table))
    # standardize values
    search_for  <- standardize(search_for)
    col_names   <- standardize_vector(columns)
    # Get the matched indices
    indices     <- find_value(search_for, col_names, fuzzy)
    # Add the findings to
    if ( !is.null(indices) ) {
      indices_matched <- c(indices_matched, indices)
      for ( match_counter in 1:length(indices) ) {
        # tables_matched  <- c(tables_matched, get_table_name(current_table))
        tables_matched  <- c(tables_matched, table_counter)
        columns_names   <- c(columns_names, columns[indices[match_counter]])
      }
    }
  }
  # Report the output
  if ( is.null(tables_matched) ) {
    print("There were no matches found!")
    return(NULL)
  }

  output <- as.data.frame(matrix(
    c(tables_matched, indices_matched, columns_names),
    ncol = 3,
    byrow = FALSE,
    dimnames = list(NULL, c("Table Index", "Matched Column's Index Within the Tabel", "Matched Column Name"))
  ))

  # Return the output
  return(output)

}
