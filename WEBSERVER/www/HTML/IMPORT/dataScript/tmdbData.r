library(readr)
filePath = "../../CLEAN_DATA/TMDB/"
tmdb <- read_csv(paste(filePath,"tmdb.csv",sep=""),col_types = "?")