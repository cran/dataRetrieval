% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readNWISunit.R
\name{readNWISmeas}
\alias{readNWISmeas}
\title{Surface-water measurement data retrieval from USGS (NWIS)}
\usage{
readNWISmeas(
  siteNumbers,
  startDate = "",
  endDate = "",
  tz = "UTC",
  expanded = FALSE,
  convertType = TRUE
)
}
\arguments{
\item{siteNumbers}{character USGS site number (or multiple sites).  This is usually an 8 digit number}

\item{startDate}{character starting date for data retrieval in the form YYYY-MM-DD. Default is "" which indicates
retrieval for the earliest possible record.}

\item{endDate}{character ending date for data retrieval in the form YYYY-MM-DD. Default is "" which indicates
retrieval for the latest possible record.}

\item{tz}{character to set timezone attribute of dateTime. Default is "UTC", and converts the
date times to UTC, properly accounting for daylight savings times based on the data's provided tz_cd column.
Possible values to provide are "America/New_York", "America/Chicago", "America/Denver", "America/Los_Angeles",
"America/Anchorage", as well as the following which do not use daylight savings time: "America/Honolulu",
"America/Jamaica", "America/Managua", "America/Phoenix", and "America/Metlakatla". See also  \code{OlsonNames()}
for more information on time zones.}

\item{expanded}{logical. Whether or not (TRUE or FALSE) to call the expanded data.}

\item{convertType}{logical, defaults to \code{TRUE}. If \code{TRUE}, the function will
convert the data to dates, datetimes,
numerics based on a standard algorithm. If false, everything is returned as a character}
}
\value{
A data frame with at least the following columns:
\tabular{lll}{
Name \tab Type \tab Description \cr
agency_cd \tab character \tab The NWIS code for the agency reporting the data\cr
site_no \tab character \tab The USGS site number \cr
measurement_dt \tab POSIXct \tab The date and time (in POSIXct) of the measurement. Unless specified
with the tz parameter, this is converted to UTC. If the measurement_dt column is
an incomplete, a measurement_dt_date and
measurement_dt_time column are added to the returned data frame.   \cr
tz_cd \tab character \tab The time zone code for the measurement_dt column \cr
}

See \url{https://waterdata.usgs.gov/usa/nwis/sw} for details about surface water, and
\url{https://waterdata.usgs.gov/nwis/help?output_formats_help}
for help on the columns and codes.

There are also several useful attributes attached to the data frame:
\tabular{lll}{
Name \tab Type \tab Description \cr
url \tab character \tab The url used to generate the data \cr
queryTime \tab POSIXct \tab The time the data was returned \cr
comment \tab character \tab Header comments from the RDB file \cr
siteInfo \tab data.frame \tab A data frame containing information on the requested sites \cr
tz_cd_reported \tab The originally reported time zone \cr
}
}
\description{
Reads surface-water measurement data from NWISweb. Data is retrieved from \url{https://waterdata.usgs.gov/nwis}.
See \url{https://waterdata.usgs.gov/usa/nwis/sw} for details about surface water.
}
\examples{
\dontshow{if (is_dataRetrieval_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
site_ids <- c("01594440", "040851325")
\donttest{
data <- readNWISmeas(site_ids)
Meas05316840 <- readNWISmeas("05316840")
Meas05316840.ex <- readNWISmeas("05316840", expanded = TRUE)
Meas07227500.ex <- readNWISmeas("07227500", expanded = TRUE)
Meas07227500.exRaw <- readNWISmeas("07227500", expanded = TRUE, convertType = FALSE)
}
\dontshow{\}) # examplesIf}
}
\seealso{
\code{\link[=constructNWISURL]{constructNWISURL()}}, \code{\link[=importRDB1]{importRDB1()}}
}
