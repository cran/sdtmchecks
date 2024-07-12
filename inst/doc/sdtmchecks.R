## ---- message=FALSE,eval=FALSE------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("pharmaverse/sdtmchecks", ref="main")

## ---- message=FALSE-----------------------------------------------------------
library(sdtmchecks) 

## ---- message=FALSE-----------------------------------------------------------
# type ??sdtmchecks into the console
??sdtmchecks 

## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  #Just type this in
#  sdtmchecksmeta

## ---- message=FALSE, echo=FALSE-----------------------------------------------
meta<-subset(sdtmchecksmeta, select=c("check","xls_title","category","priority","domains"))
colnames(meta)<-c("check","title","category","priority", "domains")
head(meta,n=10)
    

## ---- message=FALSE, echo=FALSE-----------------------------------------------
# Create sample data frames
 AE <- data.frame(
  USUBJID = 1:3,
  AEDECOD = c("AE1","AE2","AE3"),
  AEDTHDTC = c("2017-01-01","2017",NA),
  stringsAsFactors=FALSE
 )
 DS <- data.frame(
  USUBJID = 4:7,
  DSSCAT = "STUDY DISCON", 
  DSDECOD = "DEATH",
  DSSTDTC = c("2018-01-01","2017-03-03","2018-01-02","2016-10"),
  stringsAsFactors=FALSE
 )

## ---- message=FALSE-----------------------------------------------------------
# Use sample data frames.
AE
DS
# Run the data check.
check_ae_ds_partial_death_dates(AE,DS)

## ---- message=FALSE, error=FALSE, warning=FALSE, eval=FALSE-------------------
#  
#  # Read data to your global environment
#  ae = haven::read_sas("path/to/ae.sas7bdat")
#  ds = haven::read_sas("path/to/ds.sas7bdat")
#  
#  # Run the checks and save as an object called "myreport"
#  myreport=run_all_checks(metads = sdtmchecksmeta,
#                 priority = c("High", "Medium", "Low"), #subset checks based on priority
#                 type = c("ALL", "ONC", "COVID", "PRO", "OPHTH"), #subset checks based category
#                 verbose = TRUE)
#  
#  class(myreport) #results in a list object
#  names(myreport) #each check result is saved in a slot of the list
#  myreport[["check_ae_aedecod"]] #investigate the results of a check

## ---- message=FALSE, error=FALSE, warning=FALSE, eval=FALSE-------------------
#  
#  myreport=run_all_checks(metads = sdtmchecksmeta,
#                 priority = c("High"),
#                 type = c("ONC"),
#                 verbose = TRUE)

## ---- message=FALSE, error=FALSE, warning=FALSE, eval=FALSE-------------------
#  
#  # Read data to your global environment
#  ae = haven::read_sas("path/to/ae.sas7bdat")
#  cm = haven::read_sas("path/to/cm.sas7bdat")
#  dm = haven::read_sas("path/to/dm.sas7bdat")
#  
#  # Subset to checks that should work OK for most datasets
#  metads = sdtmchecksmeta %>%
#    filter(check %in% c("check_ae_aedecod",
#                        "check_ae_aetoxgr",
#                        "check_ae_dup",
#                        "check_cm_cmdecod",
#                        "check_cm_missing_month",
#                        "check_dm_age_missing",
#                        "check_dm_usubjid_dup",
#                        "check_dm_armcd"
#                        ))
#  
#  myreport=run_all_checks(metads = metads,
#                 verbose = TRUE)

## ---- message=FALSE, error=FALSE, warning=FALSE, eval=FALSE-------------------
#  
#  report_to_xlsx(res=myreport,outfile="check_report.xlsx")
#  

## ---- message=FALSE, error=FALSE, warning=FALSE, eval=FALSE-------------------
#  
#  create_R_script(file = "run_the_checks.R")
#  

