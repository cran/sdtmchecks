## ---- message=FALSE, eval=FALSE-----------------------------------------------
#  #Just type this in
#  sdtmchecksmeta

## ---- message=FALSE, echo=FALSE-----------------------------------------------
library(sdtmchecks)
meta<-subset(sdtmchecksmeta, select=c("check","domains","xls_title","pdf_title"))
colnames(meta)<-c("check","domains","title", "description")
head(meta,n=10)
    

## ----  message=FALSE, error=FALSE, warning=FALSE------------------------------
#' Example check
#'
#' @param DM 
#'
#' @return boolean
#' @export
#'
#' @examples
#'
#' \dontrun{
#'    check_dm_age_missing(DM)
#'   }
#'

check_dm_age_missing <- function(DM){
  ###First check that required variables exist and return a message if they don't
  if(DM %lacks_any% c("USUBJID","AGE")){
      fail(lacks_msg(DM, c("USUBJID","AGE")))
  }else{
    ### Subset DM to only records with missing AGE
    mydf_0 = subset(DM, is_sas_na(DM$AGE), c("USUBJID","AGE"))
    ### Subset DM to only records with AGE<18
    mydf_1 = subset(DM, !is_sas_na(DM$AGE) & DM$AGE<18, c("USUBJID","AGE"))
    ### Subset DM to only records with AGE>90
    mydf_2 = subset(DM, !is_sas_na(DM$AGE) & DM$AGE>=90, c("USUBJID","AGE"))
    ### Combine records with abnormal AGE
    mydf3 = rbind(mydf_0, mydf_1, mydf_2)
    mydf = mydf3[order(mydf3$USUBJID),]
    rownames(mydf)=NULL
    ###Print to report
    ### Return message if no records with missing AGE, AGE<18 or AGE>90
    if(nrow(mydf)==0){
      pass()
      ### Return subset dataframe if there are records with missing AGE, AGE<18 or AGE>90
    }else if(nrow(mydf)>0){
      fail(paste("DM has ",length(unique(mydf$USUBJID)),
                   " patient(s) with suspicious age value(s). ",sep=""),
             mydf)
        }
  }
}

