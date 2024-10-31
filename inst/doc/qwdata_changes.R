## ----setup, include=FALSE, message=FALSE------------------
library(knitr)
library(dataRetrieval)
library(dplyr)

options(continue = " ")

knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  fig.height = 7,
  fig.width = 7
)

## ----eval=FALSE-------------------------------------------
#  wqpData <- readWQPqw(paste0("USGS-", site_ids), parameterCd)

## ----echo=FALSE-------------------------------------------
nwisData <- readRDS("nwisData.rds")
wqpData <- readRDS("wqpData.rds")

## ---------------------------------------------------------
nrow(nwisData)
nrow(wqpData)

## ---------------------------------------------------------
ncol(nwisData)
ncol(wqpData)

## ---------------------------------------------------------
names(attributes(nwisData))
names(attributes(wqpData))

## ---------------------------------------------------------
site_NWIS <- attr(nwisData, "siteInfo")
site_WQP <- attr(wqpData, "siteInfo")

## ---------------------------------------------------------
library(dplyr)

nwisData_relevant <- nwisData |> 
  select(
    site_no, startDateTime, parm_cd,
    remark_cd, result_va
  ) |> 
  arrange(startDateTime, parm_cd)

knitr::kable(head(nwisData_relevant))

## ---------------------------------------------------------
wqpData_relevant <- wqpData |> 
  select(
    site_no = Location_Identifier,
    startDateTime = Activity_StartDateTime,
    parm_cd = USGSpcode,
    remark_cd = Result_ResultDetectionCondition,
    result_va = Result_Measure,
    detection_level = DetectionLimit_MeasureA
  ) |> 
  arrange(startDateTime, parm_cd)
knitr::kable(head(wqpData_relevant))

## ---------------------------------------------------------

censored_text <- c(
  "Not Detected",
  "Non-Detect",
  "Non Detect",
  "Detected Not Quantified",
  "Below Quantification Limit"
)

wqpData_relevant <- wqpData |> 
  mutate(left_censored = grepl(paste(censored_text, collapse = "|"),
    Result_ResultDetectionCondition,
    ignore.case = TRUE
  )) |> 
  select(
    site_no = Location_Identifier,
    startDateTime = Activity_StartDateTime,
    parm_cd = USGSpcode,
    left_censored,
    result_va = Result_Measure,
    detection_level = DetectionLimit_MeasureA,
    dl_units = DetectionLimit_MeasureUnitA
  ) |> 
  arrange(startDateTime, parm_cd)

knitr::kable(head(wqpData_relevant))

## ----whatdata, eval=FALSE---------------------------------
#  whatNWIS <- whatNWISdata(
#    siteNumber = site_ids,
#    service = "qw"
#  )

## ----whatdatanew, eval=FALSE------------------------------
#  whatWQP <- whatWQPdata(siteNumber = paste0("USGS-", site_ids))

## ----echo=TRUE, eval=TRUE---------------------------------
schema <- readr::read_csv("https://www.epa.gov/system/files/other-files/2024-07/schema_outbound_wqx3.0.csv")

## ----echo=TRUE, eval=TRUE---------------------------------
sub_schema <- schema |> 
  select(WQX3 = FieldName3.0,
         WQX2 = FieldName2.0.Narrow) |> 
  filter(!is.na(WQX2))

knitr::kable(sub_schema)


