#' Match Two Tables and Gather the Data in One of Them
#'
#' This function matches two tables based on a mutual column and gathers the specified column of data from one table into another.
#' It provides an option for fuzzy matching, allowing for minor differences between the values in the mutual column.
#'
#' @param get_from A dataframe that will provide data.
#' @param add_to A dataframe that will receive the new data for each match.
#' @param get_column The column containing the data needed to be imported for each match.
#' @param according_to A mutual column between the tables, which the matching process is based on.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is FALSE.
#'
#' @return A dataframe with the data from the specified column added to the `add_to` dataframe.
#'
#' @examples
#' df3 <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
#' df4 <- data.frame(Name = c("Alice", "Bob"), Salary = c(50000, 60000))
#' match_two_tables(df3, df4, "Age", "Name", fuzzy = TRUE)
#'
#' @export


# A function to match two tables together # DONE
match_two_tables <- function(get_from, add_to, get_column, according_to, fuzzy = FALSE) {

  # Doing some validations
  if ( !is.data.frame(get_from) | !is.data.frame(add_to)  ) {
    print("ERROR: get_from and add_to variables must be in the form of dataframe!")
    return(add_to)
  }
  if ( !(get_column %in% colnames(get_from)) ) {
    print(paste("ERROR: Column '", get_column, "' couldn't be found in this table!"))
    return(add_to)
  }
  if ( !(according_to %in% colnames(get_from)) | !(according_to %in% colnames(add_to)) ) {
    print("ERROR: according_to must be a mutual column name in both data frames!")
    return(add_to)
  }
  if ( !is.logical(fuzzy) ) {
    print("ERROR: fuzzy variable must be boolean!")
    return(add_to)
  }

  # Start the process

  # Creating the new column in the modifiable table if it doesn't exist
  if ( !(get_column %in% colnames(add_to)) ) {
    # new_column <- NULL # The old fashion
    add_to[get_column] <- NA
  }

  # Getting the two columns that will be matched
  mutual_column__in_modifiable_table  <- unlist(add_to[according_to])
  mutual_column__in_reference_table   <- unlist(get_from[according_to])
  values_to_be_moved <- unlist(get_from[get_column])

  names(mutual_column__in_modifiable_table) <- NULL
  names(mutual_column__in_reference_table)  <- NULL
  names(values_to_be_moved)  <- NULL

  # Match each value with its corresponding one
  for (modifiable_table__index_counter in 1:length(mutual_column__in_modifiable_table)) {

    current_seeked_value <- mutual_column__in_modifiable_table[modifiable_table__index_counter]
    current_output <- NA

    # Get the first match index
    match_index <- first_match(current_seeked_value, mutual_column__in_reference_table, fuzzy = fuzzy)
    if ( !is.null(match_index) ) {
      current_output <- values_to_be_moved[match_index]
      # print(paste(current_seeked_value, " Was Successfully Matched With: ", mutual_column__in_reference_table[match_index]))
    }

    # Add to the column
    # new_column <- c(new_column, current_output)
    if ( !is.na(current_output) ) {
      add_to[ add_to[according_to] == current_seeked_value, get_column ] <- current_output
    }

  }

  # Add the new column to the table
  # add_to$get_column <- new_column

  # Return the modified table
  return(add_to)

}

