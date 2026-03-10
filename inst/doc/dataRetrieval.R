## ----setup, include=FALSE, message=FALSE------------------
library(knitr)
library(dataRetrieval)

options(continue = " ")
options(width = 60)
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.height = 7,
  fig.width = 7
)

## ----workflow, echo=TRUE,eval=FALSE-----------------------
# library(dataRetrieval)
# # Choptank River near Greensboro, MD
# siteNumber <- "USGS-01491000"
# ChoptankInfo <- read_waterdata_monitoring_location(siteNumber)
# parameterCd <- "00060"
# 
# # Raw daily data:
# rawDailyData <- read_waterdata_daily(monitoring_location_id = siteNumber,
#                                      parameter_code = parameterCd,
#                                      time = c("1980-01-01", "2010-01-01"))
# 
# 
# pCode <- read_waterdata_parameter_codes(parameter_code = parameterCd)

## ----echo=FALSE-------------------------------------------
Functions <- c(
  "read_waterdata",
  "read_waterdata_daily",
  "read_waterdata_continuous",
  "readNWISrating",
  "read_waterdata_field_measurements",
  "readNWISpeak",
  "read_waterdata_field_measurements",
  "readNWISuse",
  "read_waterdata_stats_por, read_waterdata_stats_daterange",
  "read_waterdata_parameter_codes",
  "read_waterdata_monitoring_location",
  "read_waterdata_samples",
  "summarize_waterdata_samples",
  "whatNWISsites",
  "read_waterdata_ts_meta",
  "readWQPdata",
  "readWQPqw",
  "whatWQPsites",
  "whatWQPdata",
  "readWQPsummary",
  "whatWQPmetrics",
  "whatWQPsamples"
)

Description <- c(
  "Time series data using user-specified queries", # read_waterdata
  "Daily values", # read_waterdata_daily
  "Instantaneous values", # read_waterdata_continuous
  "Rating table for active streamgage", # readNWISrating
  "Surface-water measurements", # read_waterdata_field_measurements
  "Peak flow", # readNWISpeak
  "Groundwater levels", # read_waterdata_field_measurements
  "Water use", # readNWISuse
  "Statistical service", # readNWISstat
  "Parameter code information", # read_waterdata_parameter_codes
  "Site information", # read_waterdata_monitoring_location
  "Discrete UGSS water quality data", # read_waterdata_samples
  "Discrete USGS water quality summary",
  "Site search using user-specified queries",
  "Data availability",
  "User-specified queries",
  "Water quality data",
  "Site search",
  "Data availability",
  "Summary data",
  "Metric availability",
  "Sample availability"
)
Source <- c("USGS Water Data API",
            "USGS Water Data API",
            "USGS Water Data API",
            "NWIS",
            "USGS Water Data API",
            "NWIS",
            "USGS Water Data API",
            rep("NWIS",2),
            "USGS Water Data API",
            "USGS Water Data API",
            "USGS Samples Data",
            "USGS Samples Data",
            "NWIS",
            "USGS Water Data API",
            rep("WQP", 7))


data.df <- data.frame(
  Name = Functions,
  `Data Returned` = Description,
  Source, stringsAsFactors = FALSE
)

kable(data.df,
  caption = "Table 1: dataRetrieval functions"
)

## ----tableParameterCodes, echo=FALSE----------------------


pCode <- c("00060", "00065", "00010", "00045", "00400")
shortName <- c(
  "Discharge [ft<sup>3</sup>/s]",
  "Gage height [ft]",
  "Temperature [C]",
  "Precipitation [in]",
  "pH"
)

data.df <- data.frame(pCode, shortName, stringsAsFactors = FALSE)

kable(data.df,
  caption = "Table 2: Common USGS Parameter Codes"
)

## ----tableStatCodes, echo=FALSE---------------------------
StatCode <- c("00001", "00002", "00003", "00008")
shortName <- c("Maximum", "Minimum", "Mean", "Median")

data.df <- data.frame(StatCode, shortName, stringsAsFactors = FALSE)

kable(data.df,
  caption = "Table 3: Commonly used USGS Stat Codes"
)

## ----getSite, echo=TRUE, eval=FALSE-----------------------
# siteNumbers <- c("USGS-01491000", "USGS-01645000")
# siteINFO <- read_waterdata_monitoring_location(siteNumbers)

## ----getSiteExtended, echo=TRUE, eval=FALSE---------------
# # Continuing from the previous example:
# # This pulls out just the daily, mean data:
# 
# dailyDataAvailable <- read_waterdata_ts_meta(
#   monitoring_location_id = siteNumbers,
#   computation_period_identifier = "Daily",
#   statistic_id = "00003"
# )

## ----echo=FALSE, eval=FALSE-------------------------------
# 
# tableData <- dailyDataAvailable[c("monitoring_location_id",
#                          "parameter_description",
#                          "unit_of_measure",
#                          "begin", "end")]
# 
# tableData$begin <- as.Date(tableData$begin)
# tableData$end <- as.Date(tableData$end)
# tableData <- sf::st_drop_geometry(tableData)
# 
# 
# knitr::kable(tableData,
#              caption = "Table 4: Reformatted version of output from the read_waterdata_ts_meta function for the Choptank River near Greensboro, MD, and from Seneca Creek at Dawsonville, MD from the daily values service [Some columns deleted for space considerations]")
# 
# 
# # nolint end

## ----label=getPCodeInfo, echo=TRUE, eval=FALSE------------
# # Using defaults:
# parameterCd <- "00618"
# parameterINFO <- read_waterdata_parameter_codes(parameter_code = parameterCd)

## ----label=getNWISDaily, echo=TRUE, eval=FALSE------------
# 
# # Choptank River near Greensboro, MD:
# siteNumber <- "USSG-01491000"
# parameterCd <- "00060" # Discharge
# startDate <- "2009-10-01"
# endDate <- "2012-09-30"
# 
# discharge <- read_waterdata_daily(monitoring_location_id = siteNumber,
#                                   parameter_code = parameterCd,
#                                   time = c(startDate, endDate))

## ----label=getNWIStemperature, echo=TRUE, eval=FALSE------
# siteNumber <- "USGS-01491000"
# parameterCd <- c("00010", "00060") # Temperature and discharge
# statCd <- c("00001", "00003") # Mean and maximum
# startDate <- "2012-01-01"
# endDate <- "2012-05-01"
# 
# temperatureAndFlow <- read_waterdata_daily(monitoring_location_id = siteNumber,
#                                   parameter_code = parameterCd,
#                                   statistic_id = statCd,
#                                   time = c(startDate, endDate))

## ----label=getNWIStemperature2, echo=FALSE, eval=TRUE-----
filePath <- system.file("extdata", package = "dataRetrieval")
fileName <- "temperatureAndFlow.RData"
fullPath <- file.path(filePath, fileName)
load(fullPath)

## ---------------------------------------------------------

temperature <- temperatureAndFlow[temperatureAndFlow$parameter_code == "00010",]
temperature <- temperature[temperature$statistic_id == "00001",]

flow <- temperatureAndFlow[temperatureAndFlow$parameter_code == "00060",]

par(mar = c(5, 5, 5, 5)) # sets the size of the plot window

plot(temperature$time, temperature$value,
  ylab = "Maximum Temperture [C]",
  xlab = ""
)
par(new = TRUE)
plot(flow$time,
  flow$value,
  col = "red", type = "l",
  xaxt = "n", yaxt = "n",
  xlab = "", ylab = "",
  axes = FALSE
)
axis(4, col = "red", col.axis = "red")
mtext("Discharge [ft3/s]", side = 4, line = 3, col = "red")
title("CHOPTANK RIVER NEAR GREENSBORO, MD")
legend("topleft", unique(temperatureAndFlow$unit_of_measure),
  col = c("black", "red"), lty = c(NA, 1),
  pch = c(1, NA)
)

## ----label=readNWISuv, eval=FALSE-------------------------
# 
# parameterCd <- "00060" # Discharge
# startDate <- "2012-05-12"
# endDate <- "2012-05-13"
# dischargeUnit <- read_waterdata_continuous(monitoring_location_id = siteNumber,
#                                            parameter_code = parameterCd,
#                                            time = c(startDate, endDate))
# 

## ----gwlexample, echo=TRUE, eval=FALSE--------------------
# siteNumber <- "USGS-434400121275801"
# groundWater <- read_waterdata_field_measurements(monitoring_location_id = siteNumber)

## ----peakexample, echo=TRUE, eval=FALSE-------------------
# siteNumber <- "01594440"
# peakData <- readNWISpeak(siteNumber)

## ----ratingexample, echo=TRUE, eval=FALSE-----------------
# ratingData <- readNWISrating(siteNumber, "base")
# attr(ratingData, "RATING")

## ----surfexample, echo=TRUE, eval=FALSE-------------------
# surfaceData <- read_waterdata_field_measurements(monitoring_location_id = "USGS-01594440")

## ----eval=FALSE-------------------------------------------
# discharge_stats_por <- read_waterdata_stats_por(
#   monitoring_location_id = "USGS-05428500",
#   parameter_code = "00060"
# )
# 
# discharge_stats_daterange <- read_waterdata_stats_daterange(
#   monitoring_location_id = "USGS-05428500",
#   parameter_code = "00060"
# )

## ----label=getQWData, echo=TRUE, eval=FALSE---------------
# specificCond <- readWQPqw(
#   "WIDNR_WQX-10032762",
#   "Specific conductance",
#   "2011-05-01", "2011-09-30"
# )

## ----NJChloride, eval=FALSE-------------------------------
# 
# sitesNJ <- whatWQPsites(
#   statecode = "US:34",
#   characteristicName = "Chloride"
# )

## ----phData, eval=FALSE-----------------------------------
# dataPH <- readWQPdata(
#   statecode = "US:55",
#   characteristicName = "pH"
# )

## ----eval=FALSE-------------------------------------------
# type <- "Stream"
# sites <- whatWQPdata(countycode = "US:55:025", siteType = type)

## ----eval=FALSE-------------------------------------------
# site <- whatWQPsamples(siteid = "USGS-01594440")

## ----eval=FALSE-------------------------------------------
# type <- "Stream"
# sites <- whatWQPmetrics(countycode = "US:55:025", siteType = type)

## ----seeVignette,eval = FALSE-----------------------------
# # to see all available vignettes:
# vignette(package="dataRetrieval")
# 
# #to open a specific vignette:
# vignette(topic = "qwdata_changes", package = "dataRetrieval")

## ----cite, eval=TRUE--------------------------------------
citation(package = "dataRetrieval")

## ----nwisCite, eval=FALSE---------------------------------
# 
# dv <- read_waterdata_daily(monitoring_location_id = "USGS-04085427",
#                            parameter_code = "00060",
#                            time = c("2012-01-01", "2012-06-30"))
# 
# NWIScitation <- create_NWIS_bib(dv)
# NWIScitation

## ----show1, eval=FALSE------------------------------------
# print(NWIScitation, style = "Bibtex")

## ----show2, eval=FALSE------------------------------------
# print(NWIScitation, style = "citation")

## ----WQPcite, eval=FALSE----------------------------------
# SC <- readWQPqw(siteNumbers = "USGS-05288705",
#                 parameterCd = "00300")
# 
# WQPcitation <- create_WQP_bib(SC)
# WQPcitation

## ----show3, eval=FALSE------------------------------------
# print(WQPcitation, style = "Bibtex")

## ----show4, eval=FALSE------------------------------------
# print(WQPcitation, style = "citation")

