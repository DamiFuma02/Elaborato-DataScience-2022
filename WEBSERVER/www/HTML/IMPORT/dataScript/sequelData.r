library(readr)
filePath = "../../CLEAN_DATA/SEQUELS/"
sequels <- read_csv(paste(filePath,"sequels.csv",sep=""),col_types = "?")
sequelGenres = read_csv(paste(filePath,"sequelGenres.csv",sep=""),col_types = "?")