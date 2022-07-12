library(readr)
filePath = "./www/CLEAN_DATA/TMDB/"
tmdb <- read_csv(paste(filePath,"tmdb.csv",sep=""),col_types = "?")