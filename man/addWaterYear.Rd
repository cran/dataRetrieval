% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/addWaterYear.R
\name{addWaterYear}
\alias{addWaterYear}
\title{add a water year column}
\usage{
addWaterYear(rawData)
}
\arguments{
\item{rawData}{the daily- or unit-values datset retrieved from NWISweb. Must
have at least one of the following columns to add the new water year columns:
\code{dateTime}, \code{Date}, \code{ActivityStartDate}, or \code{ActivityEndDate}. The date column(s)
can be character, POSIXct, Date. They cannot be numeric.}
}
\value{
data.frame with an additional integer column with "WY" appended to the
date column name. For WQP, there will be 2 columns: \code{ActivityStartDateWY} and
\code{ActivityEndDateWY}.
}
\description{
Add a column to the dataRetrieval data frame with the water year. WQP
queries will return a water year column for the start and end dates
of the data.
}
\examples{
\donttest{
nwisData <- readNWISdv("04085427", "00060", "2022-01-01", "2022-06-30")
nwisData <- addWaterYear(nwisData)

wqpData <- readWQPqw("USGS-01594440", "01075", "", "")
wqpData <- addWaterYear(wqpData)
}
}
