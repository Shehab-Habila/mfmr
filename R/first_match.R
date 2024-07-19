#' Get the Index of the First Match in a Vector
#'
#' This function searches for a target string within a reference vector and returns the index of the first match.
#' It provides an option for fuzzy matching, allowing for minor differences between the target string and the elements in the reference vector.
#'
#' @param target The target string that you are looking for.
#' @param ref_vector The vector that will be searched.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is FALSE.
#'
#' @return The index of the first match where the target string matches an element in the reference vector. Returns NULL if no match is found.
#'
#' @examples
#' ref_vector <- c("apple", "banana", "cherry", "date")
#' first_match("apple", ref_vector)
#' first_match("banana", ref_vector, fuzzy = TRUE)
#'
#' ref_vector2 <- c("Allice", "Bob", "Carol", "David")
#' first_match("Alice", ref_vector2, fuzzy = TRUE)
#' first_match("Dave", ref_vector2, fuzzy = TRUE)
#'
#' @export

# Function to get the index of the first match in a vector # DONE
first_match <- function(target, ref_vector, fuzzy = FALSE) {

  # Doing some validations
  if ( is.null(target) | is.null(ref_vector) | !is.vector(ref_vector) | !is.logical(fuzzy) ) {
    return(NULL)
  }

  # Start the process
  output <- NULL
  for ( index_counter in 1:length(ref_vector) ) {
    if ( !is.null(match_string_to_string(target, ref_vector[index_counter], fuzzy = fuzzy)) ) {
      output <- index_counter
      break
    }
  }

  # Return the output
  return(output)

}
