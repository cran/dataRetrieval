pkg.env <- new.env()

.onLoad <- function(libname, pkgname) {
  suppressMessages(setAccess("public"))
  pkg.env$nldi_base <- "https://labs.waterdata.usgs.gov/api/nldi/linked-data/"
  pkg.env$local_sf <- requireNamespace("sf", quietly = TRUE)
}


#' Is this a dataRetrieval user
#'
#' Reveals if this is a user or not
#' @export
#' @examples
#' is_dataRetrieval_user()
is_dataRetrieval_user <- function() {
  interactive() ||
    !identical(Sys.getenv("CI"), "") ||
    identical(Sys.getenv("NOT_CRAN"), "true")
}


wqp_message <- function(){
  message("NEWS: USGS data availability and format are changing. 
Beginning in mid-March 2024 the data obtained from legacy profiles
will not include new USGS data or recent updates to existing data. 
To view the status of changes in data availability and code functionality, visit:
https://doi-usgs.github.io/dataRetrieval/articles/Status.html
If you have additional questions about these changes, 
email CompTools@usgs.gov.")
}

nwis_message <- function(){
  return("WARNING: Beginning in mid-March 2024, NWIS will not deliver
new discrete water quality data or updates to existing data. 
For updated information visit: https://waterdata.usgs.gov/nwis/qwdata
For additional details, see:
https://doi-usgs.github.io/dataRetrieval/articles/Status.html
https://doi-usgs.github.io/dataRetrieval/articles/qwdata_changes.html
If you have additional questions about the qw data service,
email CompTools@usgs.gov.")
}
