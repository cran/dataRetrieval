
#' Retrieval functions for USGS and EPA data
#'
#' \tabular{ll}{
#' Package: \tab dataRetrieval\cr
#' Type: \tab Package\cr
#' License: \tab Unlimited for this package, dependencies have more restrictive licensing.\cr
#' Copyright: \tab This software is in the public domain because it contains materials
#' that originally came from the United States Geological Survey, an agency of
#' the United States Department of Interior. For more information, see the
#' official USGS copyright policy at
#' \url{https://www.usgs.gov/information-policies-and-instructions/copyrights-and-credits}\cr
#' LazyLoad: \tab yes\cr
#' }
#'
#' Retrieval functions for USGS and EPA hydrologic and water quality data. 
#' 
#' Please see \url{https://pubs.er.usgs.gov/publication/tm4A10} for more information.
#'
#' @name dataRetrieval
#' @docType package
#' @importFrom stats setNames
#' @importFrom utils URLencode
#' @importFrom utils packageVersion
#' @importFrom utils tail
#' @importFrom utils unzip
#' @author Laura De Cicco \email{ldecicco@@usgs.gov}
NULL

#' List of USGS parameter codes
#'
#' Complete list of USGS parameter codes as of Oct. 13, 2020. 
#'
#' @name parameterCdFile
#' @return parameterData data frame with information about USGS parameters.
#'
#' \tabular{lll}{
#' Name \tab Type \tab Description\cr
#' parameter_cd \tab character \tab 5-digit USGS parameter code \cr
#' parameter_group_nm \tab character \tab USGS parameter group name\cr
#' parameter_nm \tab character \tab USGS parameter name\cr
#' casrn \tab character \tab Chemical Abstracts Service (CAS) Registry Number\cr
#' srsname \tab character \tab Substance Registry Services Name\cr
#' parameter_units \tab character \tab Parameter units\cr
#' }
#' 
#'
#'@docType data
#'@export parameterCdFile 
#'@examples
#'head(parameterCdFile[,1:2])
NULL




#' Data to convert USGS parameter code to characteristic names
#'
#' Data pulled from Water Quality Portal on October 13, 2020. The data was pulled from
#' \url{https://www.waterqualitydata.us/public_srsnames?mimeType=json}.
#'
#' @name pCodeToName
#' @return pCodeToName data frame with information about USGS parameters and how they
#' relate to characteristic names (useful for WQP requests).
#'
#' \tabular{lll}{
#' Name \tab Type \tab Description\cr
#' parm_cd \tab character \tab 5-digit USGS parameter code \cr
#' description \tab character \tab Parameter description\cr
#' characteristicname \tab character \tab Characteristic Name \cr
#' measureunitcode \tab character \tab Parameter units\cr
#' resultsamplefraction \tab character \tab Result sample fraction text\cr
#' resulttemperaturebasis \tab character \tab Temperature basis information\cr
#' resultstatisticalbasis \tab character \tab Statistical basis\cr
#' resulttimebasis \tab character \tab Time basis\cr
#' resultweightbasis \tab character \tab Weight basis\cr
#' resultparticlesizebasis \tab character \tab Particle size basis\cr
#' last_rev_dt \tab character \tab Latest revision of information\cr
#' }
#' @docType data
#' @export pCodeToName 
#' @keywords internal
#' @examples
#' head(pCodeToName[,1:2])
NULL

#' US State Code Lookup Table
#'
#' Data pulled from \url{https://www2.census.gov/geo/docs/reference/state.txt}
#' on April 1, 2015. 
#'
#' @name stateCd
#' @return stateCd data frame.
#'
#' \tabular{lll}{
#' Name \tab Type \tab Description\cr
#' STATE \tab character \tab FIPS State Code  \cr
#' STUSAB \tab character \tab Official United States Postal Service (USPS) Code \cr
#' STATE_NAME \tab character \tab State Name \cr
#' STATENS \tab character \tab  Geographic Names Information System Identifier (GNISID)\cr
#' }
#' @docType data
#' @export stateCd
#' @keywords USGS stateCd
#' @examples
#' head(stateCd)
NULL

#' US County Code Lookup Table
#'
#' Data pulled from \url{https://www2.census.gov/geo/docs/reference/codes/files/national_county.txt}
#' on April 1, 2015. 
#'
#' @name countyCd
#' @return countyCd data frame.
#'
#' \tabular{lll}{
#' Name \tab Type \tab Description\cr
#' STUSAB \tab character \tab State abbreviation \cr
#' STATE \tab character \tab two-digit ANSI code  \cr
#' COUNTY \tab character \tab three-digit county code \cr
#' COUNTY_NAME \tab character \tab County full name \cr
#' COUNTY_ID \tab character \tab County id \cr
#' }
#' @docType data
#' @export countyCd
#' @keywords USGS countyCd
#' @examples
#' head(countyCd)
NULL