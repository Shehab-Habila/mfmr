#' Convert Text to Standardized Version
#'
#' This function converts a given string into a standardized version by removing unwanted characters and optionally converting it to lowercase.
#'
#' @param word The string that will be standardized.
#' @param lowercase If TRUE, the output will be in lowercase. Default is TRUE.
#'
#' @return A standardized version of the input string.
#'
#' @examples
#' standardize("Hello, World!")
#' standardize("Special @# Characters!", lowercase = FALSE)
#'
#' @export


standardize <- function(word, lowercase = TRUE) {

  removed   <- c(".", "`", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "'", '"', "?", ">", "<", ":", ",", "{", "}", ";", "[", "]", " ")
  new_word  <- NULL
  num_chars <- length(unlist(strsplit(word, NULL)))

  # Substitute the prohibited chars
  normal_chars <- 0 # To make sure that the first char in the new word is a normal one
  for ( char_counter in 1:num_chars ) {
    current_letter <- substr(word, char_counter, char_counter)
    if ( current_letter %in% removed ) {
      if ( normal_chars != 0 ) {
        new_word <- paste0(new_word, "_")
      }
    } else {
      new_word <- paste0(new_word, current_letter)
      normal_chars <- normal_chars + 1
    }
  }

  # Make the word in lowercase
  if ( isTRUE(lowercase) ) {
    new_word <- tolower(new_word)
  }

  # Return the output
  return(new_word)

}
