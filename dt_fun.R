##FUNCTIONS

#' @description Check a data.table for specific pattern and replace by another
#'              string.
#' 
#' @param DT          A \code{data.table}.
#' @param pattern     A \code{character} string containing a regular expression
#'                    (or character string for fixed = TRUE) to be matched in
#'                    the given character vector. Coerced by as.character to a
#'                    character string if possible. If a character vector of
#'                    length 2 or more is supplied, the first element is used
#'                    with a warning.
#' @param replacement A \code{character} string replacement for matched pattern.
#'                    Coerced to character if possible. For fixed = FALSE this
#'                    can include backreferences "\1" to "\9" to parenthesized
#'                    subexpressions of pattern. For perl = TRUE only, it can
#'                    also contain "\U" or "\L" to convert the rest of the
#'                    replacement to upper or lower case and "\E" to end case
#'                    conversion. If a character vector of length 2 or more is
#'                    supplied, the first element is used with a warning. If NA,
#'                    all elements in the result corresponding to matches will
#'                    be set to NA.
#' @param ignore.case A \code{logical}. If FALSE, the pattern matching is case
#'                    sensitive and if TRUE, case is ignored during matching.
#' @param perl        A \code{logical}. Should Perl-compatible regexps be used?
#' @param fixed       A \code{logical}. If TRUE, pattern is a string to be
#'                    matched as is. Overrides all conflicting arguments.
#' @param useBytes    A \code{logical}. If TRUE the matching is done
#'                    byte-by-byte rather than character-by-character.
#' @value A \code{data.table}.
#' @author Yoann Pageaud.
#' @export
#' @examples
#' @references

#TODO: Edit function to make it faster using jangorecki answer: https://stackoverflow.com/questions/31516192/fast-way-to-replace-all-blanks-with-na-in-r-data-table?noredirect=1&lq=1 
dt.sub<-function(DT, pattern, replacement, ignore.case = FALSE, perl = FALSE,
                 fixed = FALSE, useBytes = FALSE){
  col.blck<-apply(apply(
    X = DT, MARGIN = 2, FUN = grepl, pattern = pattern, ignore.case=ignore.case,
    perl = perl, fixed = fixed, useBytes = useBytes), MARGIN = 2, FUN = any)
  col.blck<-names(col.blck[col.blck==TRUE])
  if(length(col.blck) != 0){
    DT<-DT[,(col.blck) := lapply(
      .SD,gsub, pattern = pattern, replacement = replacement,
      ignore.case=ignore.case, perl = perl, fixed = fixed, useBytes = useBytes),
      .SDcols=col.blck]
  } else {
    warning("Pattern not found in data.table object.")
  }
  return(DT)
}

#' @description Remove duplicated column content in a data.table.
#' 
#' @param DT A \code{data.table}.
#' @param ignore A \code{character} or \code{integer} vector specifying columns
#'               that should be ignored during duplication removal.
#' @value A \code{data.table}.
#' @author Yoann Pageaud.
#' @export
#' @examples
#' @references

dt.rm.dup<-function(DT, ignore=NULL){
  dup.cols<-names(duplicated(t(DT))[duplicated(t(DT))==TRUE])
  if(length(dup.cols)!=0){
    DT<-DT[,-c(dup.cols[!dup.cols %in% ignore]), with=FALSE]
  } else {
    warning("No duplicated column content found in data.table object.")
  }
  return(DT)
}