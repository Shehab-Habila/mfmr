#' Split String into Letters and Remove Special Characters
#'
#' This helper function takes a word as input, splits it into individual letters,
#' and removes any special characters from the resulting list of letters.
#'
#' @param word A character string that will be split into letters and cleaned from special characters.
#'
#' @return A character vector of letters from the input word, with special characters removed.
#'
#' @examples
#' split_and_remove_special("Hello! How's it going?")
#' split_and_remove_special("Test@123")
#'
#' @export

# Helper function to split words into letters and remove special characters
split_and_remove_special <- function(word) {

  # Split into letters
  word__in_letters <- unlist(strsplit(word, NULL))
  # Remove special characters
  special <- c("`", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "-", "=", "+", "'", '"', "?", ">", "<", ":", ",", "{", "}", ";", "[", "]", " ")
  word_clean <- word__in_letters[! word__in_letters%in% special]

  # Return the clean output in letters
  return(word_clean)
}





#' An Efficient Algorithm for Fuzzy Search
#'
#' This function matches two words and calculates their match accuracy.
#' It provides an option for fuzzy matching, allowing for minor differences
#' between the words.
#'
#' @param wanted_word A character string representing the first word to be matched.
#' @param ref_word A character string representing the reference word to be compared.
#' @param fuzzy A logical value indicating whether fuzzy matching should be used. Default is TRUE.
#' @param char_range An integer specifying the maximum tolerated number of added or removed characters in the reference word. Default is 2.
#'
#' @return A numeric value representing the match accuracy between the two words, or NULL if the words do not match.
#'
#' @examples
#' match_string_to_string("example", "exampel")
#' match_string_to_string("test", "tst", fuzzy = TRUE, char_range = 1)
#'
#' @export

# Function to match two words and calculate match accuracy
match_string_to_string <- function(wanted_word, ref_word, fuzzy = TRUE, char_range = 2) {

  # Doing some validations
  if ( is.na(wanted_word) | is.na(ref_word) | !is.character(wanted_word) | !is.character(ref_word) ) {
    return(NULL)
  }

  # Set up the default output
  match_accuracy <- NULL

  # Check if the two words are completely symmetrical
  if ( wanted_word == ref_word ) {
    match_accuracy <- 1
  } else { # Check if they are alike
    if ( isTRUE(fuzzy) ) {

      wanted_word__in_letters <- split_and_remove_special(wanted_word)
      ref_word__in_letters    <- split_and_remove_special(ref_word)

      # Equality in number of characters is no longer assumed
      inaccuracy <- NULL

      # If the length of reference word is greater than the length of the wanted word
      if ( length(ref_word__in_letters) %in% (length(wanted_word__in_letters) - char_range):(length(wanted_word__in_letters) + char_range) ) {
        # Setting the default basic inaccuracy
        if ( length(ref_word__in_letters) > length(wanted_word__in_letters) ) {
          inaccuracy <- ( length(ref_word__in_letters) - length(wanted_word__in_letters) ) / 2
        }
        if ( length(ref_word__in_letters) < length(wanted_word__in_letters) ) {
          inaccuracy <- ( length(wanted_word__in_letters) - length(ref_word__in_letters) ) / 2
        }
        if ( length(ref_word__in_letters) == length(wanted_word__in_letters) ) {
          inaccuracy <- 0
        }

        # Match every character in the wanted word with its corresponding in the reference one
        ref_letter_counter <- 1
        wanted_letter_counter <- 1
        while ( wanted_letter_counter <= length(wanted_word__in_letters) ) {
          if ( ref_word__in_letters[ref_letter_counter] == wanted_word__in_letters[wanted_letter_counter] ) {
            ref_letter_counter <- ref_letter_counter + 1
          }
          else {
            if ( wanted_letter_counter == length(wanted_word__in_letters) ) {
              inaccuracy <- inaccuracy + 1
            }
            else {
              # Check for alteration with the next char
              if ( ref_letter_counter < length(ref_word__in_letters) ) {
                if ( wanted_word__in_letters[wanted_letter_counter] == ref_word__in_letters[ref_letter_counter + 1] ) {
                  if ( wanted_word__in_letters[wanted_letter_counter + 1] == ref_word__in_letters[ref_letter_counter] ) {
                    # There is alteration
                    inaccuracy <- inaccuracy + 1
                    # Skip the next letter because it is already checked
                    ref_letter_counter <- ref_letter_counter + 2
                    wanted_letter_counter <- wanted_letter_counter + 1
                  } else {
                    # There is no alteration, but there is a foreign char in between
                    inaccuracy <- inaccuracy + 1
                    ref_letter_counter <- ref_letter_counter + 2
                  }
                } else { # There is no alteration or foreign char, two letters simply don't match
                  inaccuracy <- inaccuracy + 1
                  ref_letter_counter <- ref_letter_counter + 1
                }
              } else { # There is no alteration or foreign char, two letters simply don't match
                inaccuracy <- inaccuracy + 1
                ref_letter_counter <- ref_letter_counter + 1
              }
            }
          }

          if ( ref_letter_counter > length(ref_word__in_letters) ) { # You've checked all the letters in the ref word
            break
          }

          wanted_letter_counter <- wanted_letter_counter + 1
        }

        # Calculating the final match accuracy
        match_accuracy <- ( length(wanted_word__in_letters) - inaccuracy ) / length(wanted_word__in_letters)
      }

      # If the length of the reference word is too smaller or too larger than the wanted word
      else {
        match_accuracy <- 0
      }


      # Assess findings
      if ( length(wanted_word__in_letters) < 4 ) {
        if ( match_accuracy < ( (length(wanted_word__in_letters) - 1) / length(wanted_word__in_letters) ) ) {
          match_accuracy <- NULL
        }
      }
      if ( length(wanted_word__in_letters) >= 4 ) {
        if ( match_accuracy < ( (length(wanted_word__in_letters) - 2.5) / length(wanted_word__in_letters) ) ) {
          match_accuracy <- NULL
        }
      }
    }
  } # End of matching


  return(match_accuracy)

}
