library(readr)
filePath = "../../CLEAN_DATA/OSCARS/"
oscars <- read_csv(paste(filePath,"oscars.csv",sep=""),col_types = "iiccccll")