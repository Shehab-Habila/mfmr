#' Get the Index of All Matches in a Vector
#'
#' This function searches for a target string within a reference vector and returns the indices of all matches.
#' It provides an option for fuzzy matching, allowing for minor differences between the target string and the elements in the reference vector.
#'
#' @param target The target string that you are looking for.
#' @param ref_vector The vector that will be searched.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is FALSE.
#'
#' @return A vector of indices where the target string matches elements in the reference vector. Returns NULL if no matches are found.
#'
#' @examples
#' ref_vector <- c("apple", "banana", "cherry", "date")
#' find_value("apple", ref_vector)
#' find_value("banana", ref_vector, fuzzy = TRUE)
#'
#' ref_vector2 <- c("Allice", "Bob", "Carol", "David")
#' find_value("Alice", ref_vector2, fuzzy = TRUE)
#' find_value("Dave", ref_vector2, fuzzy = TRUE)
#'
#' @export

# Function to get the index of all matches in a vector # DONE
find_value <- function(target, ref_vector, fuzzy = FALSE) {

  # Doing some validations
  if ( is.null(target) | is.null(ref_vector) | !is.vector(ref_vector) | !is.logical(fuzzy) ) {
    return(NULL)
  }

  # Start the process
  output <- NULL
  for ( index_counter in 1:length(ref_vector) ) {
    if ( !is.null(match_string_to_string(target, ref_vector[index_counter], fuzzy = fuzzy)) ) {
      output <- c(output, index_counter)
    }
  }

  # Return the output
  return(output)

}
