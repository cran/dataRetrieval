% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getWebServiceData.R
\name{getWebServiceData}
\alias{getWebServiceData}
\title{Function to return data from web services}
\usage{
getWebServiceData(obs_url, ...)
}
\arguments{
\item{obs_url}{character containing the url for the retrieval}

\item{\dots}{information to pass to header request}
}
\value{
raw data from web services
}
\description{
This function accepts a url parameter, and returns the raw data. The function enhances
\code{\link[httr]{GET}} with more informative error messages.
}
\examples{
\dontshow{if (is_dataRetrieval_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
siteNumber <- "02177000"
startDate <- "2012-09-01"
endDate <- "2012-10-01"
offering <- "00003"
property <- "00060"
obs_url <- constructNWISURL(siteNumber, property, startDate, endDate, "dv")
\donttest{
rawData <- getWebServiceData(obs_url)
}
\dontshow{\}) # examplesIf}
}
