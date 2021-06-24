library(rio)

# working directory with xlsx files downloaded from MS Access (or any other source)
setwd("C:/Users/danielle.weissman/Documents/Fish_DSC_data_integration/swfsc")
xls <- dir(pattern = "xlsx")
created <- mapply(convert, xls, gsub("xlsx", "csv", xls))
unlink(xls) # delete xlsx files
