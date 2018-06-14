#' Check if object is avalanche
#'
#' @param x Any R object.
#'
#' @return Boolean indicating whether `x` is an avalanche object.
#'
#'
#' @export
is.avalanche <- function(x) {
  inherits(x, 'avalanche')
}
