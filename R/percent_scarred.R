#' Percent scarred time series
#'
#' @param x An fhx object.
#' @param injury_event Boolean indicating whether years with injury events should be considered as scars. Defaults to FALSE.
#'
#' @return A data.frame with four columns: \code{Year}, \code{NumRec} with the number of recording trees,
#' \code{NumScars} with the number of fire scars and/or events, and \code{PercScarred} with the proportion of scars/events.
#'
#' @export
percent_scarred <- function(x, injury_event=FALSE){
  if(inherits(x, "avalanche") == TRUE){
    rec_count <- burnr::sample_depth(x)
    names(rec_count) <- c("recording", "freq")
  }
  else  {
    series_rec <- plyr::ddply(x, "series", burnr::find_recording, injury_event=TRUE)
    rec_count <- plyr::count(series_rec, "recording")
  }
  series_fs <- x[grepl('_fs', x$rec_type), ]
  fs_count <- plyr::count(series_fs, "year")
  if(injury_event) {
    series_fs <- x[grepl('_fs', x$rec_type) | grepl('_fi', x$rec_type), ]
    fs_count <- plyr::count(series_fs, "year")
  }
  out <- merge(rec_count, fs_count, by.x = 'recording', by.y = 'year', all=TRUE)
  names(out) <- c('year', 'num_rec', 'num_scars')
  out[is.na(out$num_scars), 'num_scars'] <- 0
  out$percent_scarred <- round(out$num_scars / out$num_rec * 100, 0)
  return(out)
}

