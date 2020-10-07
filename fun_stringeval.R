##FUNCTIONS

#' @description Check if an alphanumerical string contains any upper case
#'              character.
#' 
#' @param str A \code{character} vector to be evaluated looking for any
#'                               uppercase character.
#' @value A \code{logical}.
#' @author Yoann Pageaud.
#' @export

is.upper<-function(str){ grepl(pattern = "[A-Z]+", x = str) }

#' @description Check if an array, a dataframe or a matrix contains any empty
#'              cell. 
#' 
#' @param data An \code{array}, a \code{dataframe} or a \code{matrix}.
#' @return A \code{logical}, TRUE if the array contains at least 1 empty cell,
#'         FALSE if it does not.
#' @author Yoann Pageaud.
#' @export

any.empty <- function(data){
  any(apply(X = data, MARGIN = 2,FUN = grepl, pattern = "^$"))
}