#' Match Multiple Tables and Gather the Data in One Place
#'
#' This function matches multiple tables based on a mutual column and gathers specified columns of data into a single dataframe.
#' It provides an option for fuzzy matching, allowing for minor differences between the values in the mutual column.
#'
#' @param get_from A list of dataframes containing the tables that will provide data.
#' @param add_to A dataframe that will receive the new data for each match.
#' @param get_columns A vector of column names containing the data needed to be imported for each match.
#' @param according_to A mutual column between the tables, which the matching process is based on.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is FALSE.
#'
#' @return A dataframe with the data from the specified columns added to the `add_to` dataframe.
#'
#' @examples
#' df4 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
#' df5 <- data.frame(Name = c("Carol", "David", "Allice"), Salary = c(40000, 50000, 60000))
#' get_from_list2 <- list(df4, df5)
#' add_to_df2 <- data.frame(Name = c("Alice", "Bob", "Carol", "David"))
#' match_tables(get_from_list2, add_to_df2, c("Age", "Salary"), "Name", fuzzy = TRUE)
#'
#' @export


# Here, get_from is a list of tables, get_column is a vector of column names #DONE
# You can get multiple columns from multiple datasets and gather them all in one place according to a reference mutual column
match_tables <- function(get_from, add_to, get_columns, according_to, fuzzy = FALSE) {

  # Doing some validations
  if ( !is.data.frame(add_to)  ) {
    print("ERROR: add_to variable must be in the form of dataframe!")
    return(add_to)
  }
  if ( !is.list(get_from) ) {
    print("ERROR: get_from variables must be a list of dataframes!")
    return(add_to)
  }
  for ( table in get_from ) {
    if ( !is.data.frame(table) ) {
      print("ERROR: get_from variables must be a list of dataframes!")
      return(add_to)
    }
  }
  columns_names <- unlist(lapply(get_from, colnames))
  if ( !(TRUE %in% (get_columns %in% columns_names)) ) {
    print("ERROR: get_columns must contain at least one name of a column in a given reference dataframes!")
    return(add_to)
  }
  if ( !(according_to %in% columns_names) | !(according_to %in% colnames(add_to)) ) {
    print("ERROR: according_to must be a mutual column name between add_to and at least one dataframe in the get_from!")
    return(add_to)
  } # The that doesn't contain the mutual column will be neglected.
  if ( !is.logical(fuzzy) ) {
    print("ERROR: fuzzy variable must be boolean!")
    return(add_to)
  }
  # Done with some assumptions: get_from is a list of dataframes, add_to is a dataframe, according_to must be a mutual column name between add_to and at least one dataframe in the get_from!.

  # Start the matching
  for ( current_table in get_from ) {

    current_table <- current_table
    for ( current_column in get_columns ) {

      updated_table <- match_two_tables(current_table, add_to, current_column, according_to, fuzzy)
      # print(updated_table)
      if ( is.data.frame(updated_table) ) { # Successful match
        add_to <- updated_table
      }
    }

  }

  # Return the output
  return(add_to)

}
