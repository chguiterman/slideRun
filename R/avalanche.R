#' Generate a class "avalanche" object
#'
#' @param series vector of series or tree names
#' @param year vector of years associated with each series and rec_type
#' @param rec_type vector of tree-ring record types. See \code{burnr} documentation
#' @param conf a category scaled 1-5 indicated the confidence assigned to a scar or wound as it relates to an avalanche event
#'
#' @return An \code{avalanche} and \code{fhx} object
#'
avalanche <- function(series, year, rec_type, conf) {
  # Constructor for `avalanche` objects.
  obj <- fhx(series=series, year=year, rec_type=rec_type)
  obj$conf <- conf
  class(obj) <- c('avalanche', class(obj))
  return(obj)
}
