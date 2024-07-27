#' Create a "Unity Table" for Categorical Column
#'
#' This function reads all the values in a categorical column and recognizes all the variations in the writing of each unique category name. It unites these variations into one value to cure categorical inconsistency.
#'
#' @param table A data frame containing the column to be processed.
#' @param column The name of the categorical column to be standardized.
#' @param char_range Numeric value indicating the character range for fuzzy matching (default is 1).
#'
#' @return A data frame with two columns: `value` containing the standardized category names, and `variations` containing lists of the original variations.
#'
#' @examples
#' df <- data.frame(ID = 1:6, Status = c("single", "Single", "SINGLE", "married", "Married", "MARRIED"))
#' unity_table <- make_unity_table(df, "Status", char_range = 1)
#' print(unity_table)
#'
#' @export

make_unity_table <- function (table, column, char_range = 1) {

  # Doing some validations
  if ( !is.data.frame(table) ) {
    stop("Variable 'table' must be a dataframe!")
  }
  if ( !(column %in% unlist(colnames(table))) ) {
    stop("This column name is not present within 'table' columns!")
  }

  # Getting the unique values from the column
  unique_column_contents <- unique(as.vector(unlist(table[column])))

  # Doing some other validations
  try(
    if ( is.na(unique_column_contents) | is.null(unique_column_contents) ) {
      stop("This column is empty!")
    },
    silent = TRUE
  )

  # Start the process
  unity_table         <- data.frame(value = NA, variations = NA)
  all_matched_values  <- NULL

  for ( ref_value in unique_column_contents ) { # A loop to check every unique value

    if ( !(ref_value %in% all_matched_values) ) { # To not check a value twice

      # Reset the parameters for each unique value
      current_similar_values <- NULL
      this_row  <- data.frame(value = NA, variations = NA)

      for ( counter in 1:length(unique_column_contents) ) {

        target_value <- unique_column_contents[counter]

        if ( !(target_value %in% all_matched_values) ) { # To not check a value twice

          # Check for similarity
          check_match  <- match_string_to_string(tolower(ref_value), tolower(target_value), char_range = char_range)

          if ( !is.null(check_match) ) {
            current_similar_values  <- c(current_similar_values, target_value)
            all_matched_values      <- c(all_matched_values, target_value) # To not check a value twice
            # unique_column_contents <- unique_column_contents[-counter] # Remove this value to not be checked again
          }

        }

      }

      this_row$value[1] <- ref_value
      this_row$variations[1] <- list(as.vector(current_similar_values))
      unity_table <- rbind(unity_table, this_row)

    }

  } # End of the for loop

  # Delete the first empty row
  unity_table <- unity_table[-1, ]

  # Returning the output
  return(unity_table)

}
