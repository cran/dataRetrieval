% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/whatWQPdata.R
\name{whatWQPdata}
\alias{whatWQPdata}
\title{Data Available from Water Quality Portal}
\usage{
whatWQPdata(..., convertType = TRUE)
}
\arguments{
\item{\dots}{see \url{https://www.waterqualitydata.us/webservices_documentation} for
a complete list of options. A list of arguments can also be supplied.
One way to figure out how to construct a WQP query is to go to the "Advanced"
form in the Water Quality Portal:
\url{https://www.waterqualitydata.us/#mimeType=csv&providers=NWIS&providers=STORET}
Use the form to discover what parameters are available. Once the query is
set in the form, scroll down to the "Query URL". You will see the parameters
after "https://www.waterqualitydata.us/#". For example, if you chose "Nutrient"
in the Characteristic Group dropdown, you will see characteristicType=Nutrient
in the Query URL. The corresponding argument for dataRetrieval is
characteristicType = "Nutrient". dataRetrieval users do not need to include
mimeType, and providers is optional (these arguments are picked automatically).}

\item{convertType}{logical, defaults to \code{TRUE}. If \code{TRUE}, the function
will convert the data to dates, datetimes,
numerics based on a standard algorithm. If false, everything is returned as a character.}
}
\value{
A data frame that returns basic data availability such as
sites, number of results, and number of sampling activities from the
query parameters for the Water Quality Portal.
}
\description{
Returns a list of sites from the Water Quality Portal web service. This function gets
the data from: \url{https://www.waterqualitydata.us}.
Arguments to the function should be based on
\url{https://www.waterqualitydata.us/webservices_documentation}.
The information returned from whatWQPdata describes the
available data at the WQP sites, and some metadata on the sites themselves.
For example, a row is returned for each individual site that fulfills this
query. In that we can learn how many sampling activities and results
are available for the query. It does not break those results down by any finer
grain. For example, if you ask for "Nutrients" (characteristicGroup), you will
not learn what specific nutrients are available at that site. For that
kind of data discovery see \code{readWQPsummary}.
}
\examples{
\dontshow{if (is_dataRetrieval_user()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\donttest{
site1 <- whatWQPdata(siteid = "USGS-01594440")

type <- "Stream"
sites <- whatWQPdata(countycode = "US:55:025", siteType = type)

lakeSites <- whatWQPdata(siteType = "Lake, Reservoir, Impoundment",
                         countycode = "US:55:025")
lakeSites_chars <- whatWQPdata(
  siteType = "Lake, Reservoir, Impoundment",
  countycode = "US:55:025", convertType = FALSE)
}

bbox <- c(-86.9736, 34.4883, -86.6135, 34.6562)
what_bb <- whatWQPdata(bBox = bbox)
\dontshow{\}) # examplesIf}
}
\seealso{
whatWQPsites readWQPsummary readWQPdata
}
\keyword{WQP}
\keyword{data}
\keyword{import}
\keyword{service}
\keyword{web}
