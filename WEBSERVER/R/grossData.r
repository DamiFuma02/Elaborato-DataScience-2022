library(readr)
filePath = "./www/CLEAN_DATA/GROSS/"
gross <- read_csv(paste(filePath,"gross.csv",sep=""),col_types = "?")
grossGenres <- read_csv(paste(filePath,"grossGenres.csv",sep=""),col_types = "?")
grossDistributors = read_csv(paste(filePath,"grossDistributors.csv",sep=""),col_types = "?")