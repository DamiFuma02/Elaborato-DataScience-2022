library(readr)
filePath = "./www/CLEAN_DATA/OSCARS/"
oscars <- read_csv(paste(filePath,"oscars.csv",sep=""),col_types = "?")