% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readNWISunit.R
\name{readNWISuv}
\alias{readNWISuv}
\title{Instantaneous value data retrieval from USGS (NWIS)}
\usage{
readNWISuv(siteNumbers, parameterCd, startDate = "", endDate = "", tz = "UTC")
}
\arguments{
\item{siteNumbers}{character USGS site number (or multiple sites).  This is usually an 8 digit number}

\item{parameterCd}{character USGS parameter code.  This is usually an 5 digit number.}

\item{startDate}{character starting date for data retrieval in the form YYYY-MM-DD. Default is "" which indicates
retrieval for the earliest possible record. Simple date arguments are specified in local time.
See more information here: \url{https://waterservices.usgs.gov/docs/instantaneous-values/}.}

\item{endDate}{character ending date for data retrieval in the form YYYY-MM-DD. Default is "" which indicates
retrieval for the latest possible record. Simple date arguments are specified in local time.
See more information here: \url{https://waterservices.usgs.gov/docs/instantaneous-values/}.}

\item{tz}{character to set timezone attribute of dateTime. Default is "UTC", and converts the
date times to UTC, properly accounting for daylight savings times based on the data's provided tz_cd column.
Possible values to provide are "America/New_York", "America/Chicago", "America/Denver", "America/Los_Angeles",
"America/Anchorage", as well as the following which do not use daylight savings time: "America/Honolulu",
"America/Jamaica", "America/Managua", "America/Phoenix", and "America/Metlakatla". See also  \code{OlsonNames()}
for more information on time zones.}
}
\value{
A data frame with the following columns:
\tabular{lll}{
Name \tab Type \tab Description \cr
agency_cd \tab character \tab The NWIS code for the agency reporting the data\cr
site_no \tab character \tab The USGS site number \cr
dateTime \tab POSIXct \tab The date and time of the value converted to UTC \cr
tz_cd \tab character \tab The time zone code for dateTime \cr
code \tab character \tab Any codes that qualify the corresponding value\cr
value \tab numeric \tab The numeric value for the parameter \cr
}
Note that code and value are repeated for the parameters requested. The names are of the form:
X_D_P_S, where X is literal,
D is an option description of the parameter,
P is the parameter code,
and S is the statistic code (if applicable).

There are also several useful attributes attached to the data frame:
\tabular{lll}{
Name \tab Type \tab Description \cr
url \tab character \tab The url used to generate the data \cr
siteInfo \tab data.frame \tab A data frame containing information on the requested sites \cr
variableInfo \tab data.frame \tab A data frame containing information on the requested parameters \cr
statisticInfo \tab data.frame \tab A data frame containing information on the requested statistics on the data \cr
queryTime \tab POSIXct \tab The time the data was returned \cr
}
}
\description{
Imports data from NWIS web service. This function gets the data from here:
\url{https://waterservices.usgs.gov/docs/instantaneous-values/instantaneous-values-details/}
Inputs to this function are just USGS site ids, USGS parameter codes,
and start and end date. For a more complex query, use \code{\link[=readNWISdata]{readNWISdata()}},
including an arguement service="uv".
Not all parameter codes are available for all data.
Use the function \code{\link[=whatNWISdata]{whatNWISdata()}} to discover what data
is available for a USGS site. The column data_type_cd with the values "uv"
returned from \code{\link[=whatNWISdata]{whatNWISdata()}}) are available from this service.
}
\details{
More information on the web service can be found here:
\url{https://waterservices.usgs.gov/test-tools}, choosing the
"Instantaneous Value Service".
}
\examples{
\dontshow{if (is_dataRetrieval_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
site_id <- "05114000"
parameterCd <- "00060"
startDate <- "2014-10-10"
endDate <- "2014-10-10"
\donttest{

rawData <- readNWISuv(site_id, parameterCd, startDate, endDate)

rawData_today <- readNWISuv(site_id, parameterCd, Sys.Date(), Sys.Date())

timeZoneChange <- readNWISuv(
  c("04024430", "04024000"), parameterCd,
  "2013-11-03", "2013-11-03"
)

centralTime <- readNWISuv(site_id, parameterCd,
  "2014-10-10T12:00", "2014-10-10T23:59",
  tz = "America/Chicago"
)

# Adding 'Z' to the time indicates to the web service to call the data with UTC time:
GMTdata <- readNWISuv(
  site_id, parameterCd,
  "2014-10-10T00:00Z", "2014-10-10T23:59Z"
)
}
\dontshow{\}) # examplesIf}
}
\seealso{
\code{\link[=renameNWISColumns]{renameNWISColumns()}}, \code{\link[=importWaterML1]{importWaterML1()}}
}
\keyword{USGS}
\keyword{data}
\keyword{import}
\keyword{service}
\keyword{web}
