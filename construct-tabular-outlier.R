source("R/load-packages.R")


GetTabularOutlierScore <- function(datasetname) {
  
  text.loaded <- readtext::readtext(paste0("data/downloaded-data/", datasetname, ".csv"))
  
  list.columns <- list()
  for (i in 1:dim(text.loaded)[1]) {
    DTtext <- data.table::as.data.table(text.loaded$text[i])
    DTtext1 <- data.table::as.data.table(str_split(DTtext, " "))
    if(i == 1){
      data.table::setnames(DTtext1, "V1", "Label")
      DT <- DTtext1[-1] 
      list.columns[[i]] <- DT
    } else{
      setnames(DTtext1, "V1", DTtext1$V1[1])
      DT <- DTtext1[-1] 
      list.columns[[i]] <- DT
    }
    DTtabular <- dplyr::bind_cols(list.columns)
    data.table::fwrite(DTtabular, paste0("data/derived-data/", datasetname, ".csv"), nThread = 2)
    return(DTtabular)
  }
  }

# example 
# GetTabularOutlierScore(datasetname = "WDBC_withoutdupl_norm_v07.results")
