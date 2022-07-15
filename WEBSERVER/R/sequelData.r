
filePath = "./www/CLEAN_DATA/SEQUELS/"
sequels <- read_delim(paste(filePath,"sequels.csv",sep=""),col_types = "?",delim = ";")
sequelGenres = read_csv(paste(filePath,"sequelGenres.csv",sep=""),col_types = "?")